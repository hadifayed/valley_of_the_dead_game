require_relative "../../game/map_components/room_factory"

describe RoomFactory do
  describe "#for" do
    context 'when given dummy text as room description' do
      it "should return room of type room" do
        expect(RoomFactory.for("iamdummytext", {}, []).is_a? Room).to be true
      end
    end

    context 'when given description starts with soldier' do
      it "should return room of type soldier" do
        expect(RoomFactory.for("soldier", {}, []).is_a? SoldierRoom).to be true
      end
    end

    context 'when given description starts with army' do
      it "should return room of type army" do
        expect(RoomFactory.for("army", {}, []).is_a? ArmyRoom).to be true
      end
    end
  end
end
