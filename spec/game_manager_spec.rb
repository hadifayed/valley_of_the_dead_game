Dir[File.join(__dir__, '..', 'game', 'map_components', 'levels', '*.rb')].each {|file| require file }
Dir[File.join(__dir__, '..', 'game', 'map_components', 'rooms', '*.rb')].each {|file| require file }
Dir[File.join(__dir__, '..', 'game', 'player_components', 'rooms', '*.rb')].each {|file| require file }
require_relative "../game/map_components/room_factory"
require_relative "../game/map_components/map"
require_relative "../game/game_manager"



describe GameManager do
  let(:level_has_next_level) { Level1.instance }
  let(:level_does_not_have_next_level) { Level2.instance }
  let(:game_manager) { GameManager.new(map: nil, player: nil, current_room: nil) }

  describe ".player_will_continue_to_play?" do
    context 'when player returns that he want to exit the game' do
      it "should return falsey value" do
        expect(game_manager.player_will_continue_to_play?(GameConstants::PLAYER_EXITED)).to be_falsey
      end
    end

    context 'when player returns that he lost fight' do
      it "should return falsey value" do
        expect(game_manager.player_will_continue_to_play?(GameConstants::FIGHT_LOST)).to be_falsey
      end
    end

    context 'when player returns that he won the last fight in the level' do
      context 'when map has next level' do
        it "should return truthy value" do
          map_with_current_level_has_next_level = Map.for(room_factory: RoomFactory, level: level_has_next_level)
          current_tested_game_manager = game_manager
          current_tested_game_manager.instance_variable_set(:@map, map_with_current_level_has_next_level)
          expect(game_manager.player_will_continue_to_play?(GameConstants::LEVEL_FINISHED)).to be_truthy
        end
      end

      context 'when map does not have next level' do
        it "should return falsey value" do
          map_with_current_level_has_no_next_level = Map.for(room_factory: RoomFactory, level: level_does_not_have_next_level)
          current_tested_game_manager = game_manager
          current_tested_game_manager.instance_variable_set(:@map, map_with_current_level_has_no_next_level)
          expect(game_manager.player_will_continue_to_play?(GameConstants::LEVEL_FINISHED)).to be_falsey
        end
      end
    end
  end
end
