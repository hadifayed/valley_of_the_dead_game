Dir[File.join(__dir__, '..', '..', 'game', 'map_components', 'levels', '*.rb')].each {|file| require file }
require_relative "../../game/map_components/map"

describe Map do
  let(:level_has_next_level) { Level1.instance }
  let(:level_does_not_have_next_level) { Level2.instance }
  let(:map_with_current_level_has_next_level) { Map.for(room_factory: RoomFactory, level: level_has_next_level) }
  let(:map_with_current_level_does_not_have_next_level) { Map.for(room_factory: RoomFactory, level: level_does_not_have_next_level) }

  describe "#for" do
    it "should return map instance" do
      expect(map_with_current_level_has_next_level.is_a? Map).to be true
    end
  end

  describe ".move_from_current_room" do
    context 'when required to move back' do
      context 'when there is a last room' do
        let(:last_room) { map_with_current_level_does_not_have_next_level.current_room }
        let(:map) do
          map = map_with_current_level_has_next_level
          map.instance_variable_set(:@last_room, last_room)
          map
        end

        it "should return truthy value" do
          expect(map.move_from_current_room(GameConstants::RETURN_TO_PREIVOUS_ROOM)).to be_truthy
        end

        it "should change map current room to be the last room" do
          expect{map.move_from_current_room(GameConstants::RETURN_TO_PREIVOUS_ROOM)}.to change{map.current_room}.from(map.current_room).to(last_room)
        end
      end

      context 'when there is no last room' do
        let(:map) do
          map = map_with_current_level_has_next_level
          map.instance_variable_set(:@last_room, nil)
          map
        end

        it "should return falsey value" do
          expect(map.move_from_current_room(GameConstants::RETURN_TO_PREIVOUS_ROOM)).to be_falsey
        end

        it "should not change map current room" do
          current_tested_map = map
          current_room = current_tested_map.current_room
          current_tested_map.move_from_current_room(GameConstants::RETURN_TO_PREIVOUS_ROOM)
          expect(current_tested_map.current_room).to be current_room
        end
      end
    end

    context 'when required to go to room at direction' do
      let(:map) { map_with_current_level_does_not_have_next_level }
      context 'when there is a room at that direction' do
        let(:direction) { map.current_room.navigation_directions.keys[0] }

        it "should return truthy value" do
          expect(map.move_from_current_room(direction)).to be_truthy
        end

        it "should change map current room to be the room at that direction" do
          moved_to_room = map.send(:get_room, map.current_room.navigation_directions[direction])
          expect{map.move_from_current_room(direction)}.to change{map.current_room}.from(map.current_room).to(moved_to_room)
        end
      end

      context 'when there is no room at that direction' do
        it "should falsey value" do
          expect(map.move_from_current_room(GameConstants::PLAYER_EXITED)).to be_falsey
        end

        it "should not change map current room" do
          current_tested_map = map
          current_room = current_tested_map.current_room
          current_tested_map.move_from_current_room(GameConstants::PLAYER_EXITED)
          expect(current_tested_map.current_room).to be current_room
        end
      end
    end
  end

  describe ".move_to_next_level" do
    context 'when map level has next level' do
      let(:map) { map_with_current_level_has_next_level }

      it "should return truthy value" do
        expect(map.move_to_next_level).to be_truthy
      end

      it "should change current room to be next_level's current_room" do
        current_tested_map = map
        finished_level_current_room = current_tested_map.current_room
        current_tested_map.move_to_next_level
        expect(current_tested_map.current_room).not_to be finished_level_current_room
      end
    end

    context 'when map level does not have next level' do
      let(:map) { map_with_current_level_does_not_have_next_level }

      it "should return falsey value" do
        expect(map.move_to_next_level).to be_falsey
      end

      it "should not change current room to be nil" do
        current_tested_map = map
        finished_level_current_room = current_tested_map.current_room
        current_tested_map.move_to_next_level
        expect(current_tested_map.current_room).to be nil
      end
    end
  end
end
