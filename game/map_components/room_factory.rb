Dir[File.join(__dir__, 'rooms' , '*.rb')].each {|file| require file }

class RoomFactory
  def self.for(room_description, navigation_directions, location)
    room_details = room_description.to_s.split(GameConstants::ROOM_STRING_SPLITER)
    get_room_class(room_details[GameConstants::ROOM_STRING_CLASS_INDEX].capitalize)
    .new(location: location,
         navigation_directions: navigation_directions,
         score: room_details[GameConstants::ROOM_STRING_SCORE_INDEX].to_i,
         weapons: room_details[GameConstants::ROOM_STRING_WEAPONS_INDEX].to_i)
  end

  private

  def self.get_room_class(class_string)
    class_name = class_string + "Room"
    Object.const_defined?(class_name) ? Object.const_get(class_name) : Room
  end
end
