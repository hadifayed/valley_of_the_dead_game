require_relative "../../../game/map_components/rooms/soldier_room"

describe SoldierRoom do

  let(:room) { SoldierRoom.new(navigation_directions: {}, location: true, score: 10, weapons: 10) }

  describe ".has_fight" do
    it "should return true by default" do
      expect(room.has_fight?).to eql(true)
    end

    it "should return true if fight was lost" do
      current_tested_room = room
      current_tested_room.send(:player_lost_fight)
      expect(current_tested_room.has_fight?).to eql(true)
    end

    it "should return false if fight won" do
      current_tested_room = room
      current_tested_room.send(:player_won_fight)
      expect(current_tested_room.has_fight?).to eql(false)
    end
  end

  describe ".fight_skipped" do
    it "should return value that takes player to preivous room" do
      expect(room.fight_skipped).to eql(GameConstants::RETURN_TO_PREIVOUS_ROOM)
    end
  end

  describe ".trigger_fight" do
    context 'when player wins fight' do
      it "should return value indicates that fight was won" do
        expect(room.trigger_fight(room.score + 1)).to eql(GameConstants::FIGHT_WON)
      end
    end

    context 'when player loses fight' do
      it "should return value indicates that fight was lost" do
        expect(room.trigger_fight(room.score - 1)).to eql(GameConstants::FIGHT_LOST)
      end
    end
  end

  describe ".fight_options" do
    context 'when player did not skip fight before' do
      it "should return fight and run options" do
        expect(room.fight_options.sort).to eql([GameConstants::RUN_OPTION, GameConstants::FIGHT_OPTION,].sort)
      end
    end

    context 'when player skipped fight before' do
      it "should return fight option only" do
        current_tested_room = room
        current_tested_room.fight_skipped
        expect(room.fight_options).to eql([GameConstants::FIGHT_OPTION,])
      end
    end
  end
end
