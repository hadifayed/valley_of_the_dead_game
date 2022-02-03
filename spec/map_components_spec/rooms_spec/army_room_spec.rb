require_relative "../../../game/map_components/rooms/army_room"

describe ArmyRoom do

  let(:room) { ArmyRoom.new(navigation_directions: {}, location: true, score: 10, weapons: 10) }


  describe ".trigger_fight" do
    context 'when player wins fight' do
      it "should return value indicates that level was finished" do
        expect(room.trigger_fight(room.score + 1)).to eql(GameConstants::LEVEL_FINISHED)
      end
    end
  end
end
