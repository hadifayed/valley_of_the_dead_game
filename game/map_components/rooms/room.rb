require_relative "#{File.join(__dir__, '..', '..', 'game_constants')}"

class Room
  attr_reader :location, :navigation_directions, :score, :weapons, :looted

  def initialize(location:, navigation_directions:, score:, weapons:)
    @location = location
    @navigation_directions = navigation_directions
    @score = score
    @weapons = weapons
    @looted = false
  end

  def has_fight?
    false
  end

  def print_entry_msg
    puts GameConstants::EMPTY_ROOM_ENTRY_MSG
  end

  def navigation_choices
    choices = @navigation_directions.keys
    print_navigation_msg(choices)
    choices
  end

  def looted_by_player
    @looted = true
  end

  private

  def print_navigation_msg(choices)
    puts GameConstants::EMPTY_ROOM_NAVIGATION_MSG + "(" + choices.join("/") + ")"
  end
end
