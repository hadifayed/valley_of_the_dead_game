require_relative "#{File.join(__dir__, '..', 'game_constants')}"

class Map
  attr_reader :current_room

  def initialize(room_factory:, current_level:, description:, starting_point:, current_room: nil, last_room: nil)
    @room_factory = room_factory
    @current_level = current_level
    @description = description
    @num_of_rows = @description.size
    @num_of_columns = @description[0].size
    @rooms = format_rooms_map
    @last_room = last_room
    @current_room = current_room || get_room(starting_point)
  end

  def move_from_current_room(direction)
    if direction == GameConstants::RETURN_TO_PREIVOUS_ROOM && !@last_room.nil?
      @current_room = @last_room
      @last_room = nil
      true
    elsif @current_room && @current_room.navigation_directions[direction]
      @last_room = @current_room
      @current_room = get_room(@current_room.navigation_directions[direction])
    end
  end

  def move_to_next_level
    return if @current_level.nil?
    @current_level.print_finishing_msg
    if @current_level.has_next_level?
      set_new_level(@current_level.next_level)
    else
      @current_level = nil
      @description = nil
      @num_of_rows = 0
      @num_of_columns = 0
      @rooms = []
      @last_room = nil
      @current_room = nil
    end
  end

  def self.for(room_factory:, level:)
    new(room_factory: room_factory, current_level: level, description:level.map_description, starting_point:level.starting_point)
  end

  private

  def set_new_level(level)
    @current_level = level
    @description = level.map_description
    @num_of_rows = @description.size
    @num_of_columns = @description[0].size
    @rooms = format_rooms_map
    @last_room = nil
    @current_room = get_room(level.starting_point)
  end

  def format_rooms_map
    Array.new(@num_of_rows) { Array.new(@num_of_columns) }
  end

  def get_room(room_index)
    if @rooms[room_index[0]][room_index[1]].nil?
      room = create_room(room_index)
      @rooms[room_index[0]][room_index[1]] = room
    else
      @rooms[room_index[0]][room_index[1]]
    end
  end

  def create_room(room_index)
    navigation_directions = generate_navigation_directions_for_room(room_index)
    room_description = @description[room_index[0]][room_index[1]]
    @room_factory.for(room_description, navigation_directions, room_index)
  end


  def generate_navigation_directions_for_room(room_index)
    navigation_directions = {}
    [GameConstants::RIGHT, GameConstants::LEFT, GameConstants::FORWARD, GameConstants::BACKWORD].each do |direction|
      room_index_at_direction = get_room_index_at_direction(room_index, direction)
      if valid_room_index?(room_index_at_direction)
        navigation_directions[direction] = room_index_at_direction
      end
    end
    navigation_directions
  end

  def get_room_index_at_direction(room_index, direction)
    case direction
    when GameConstants::RIGHT
      [room_index[0], room_index[1] + 1]
    when GameConstants::LEFT
      [room_index[0], room_index[1] - 1]
    when GameConstants::FORWARD
      [room_index[0] - 1, room_index[1]]
    when GameConstants::BACKWORD
      [room_index[0] + 1, room_index[1]]
    end
  end

  def valid_room_index?(room_index)
    index_within_map?(room_index) && index_has_room?(room_index)
  end

  def index_within_map?(room_index)
    room_index[0].between?(0,(@num_of_rows - 1)) && room_index[1].between?(0,(@num_of_columns - 1))
  end

  def index_has_room?(room_index)
    !@description[room_index[0]][room_index[1]].nil?
  end
end
