Dir[File.join(__dir__, 'player_components', '*.rb')].each {|file| require file }
Dir[File.join(__dir__, 'map_components', 'levels', '*.rb')].each {|file| require file }
require_relative "#{File.join(__dir__, 'map_components', 'map')}"
require_relative "#{File.join(__dir__, 'map_components', 'room_factory')}"
require_relative "game_manager"

puts GameConstants::GAME_ENTRANCE_MSG
input_taker = InputTaker.new
player = Player.new(input_taker: input_taker)
map = Map.for(room_factory: RoomFactory, level: Level1.instance)
game_manager = GameManager.new(player: player, map: map, current_room: map.current_room)
player_will_play = true
while player_will_play
  player_move_response = game_manager.move_player_to_current_room
  player_will_play = game_manager.player_will_continue_to_play?(player_move_response)
end
