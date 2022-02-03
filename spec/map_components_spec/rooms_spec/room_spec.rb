require_relative "../../../game/map_components/rooms/room"

describe Room do

  let(:navigation_directions) { { hello: true, bye: true } }
  let(:room) { Room.new(navigation_directions: navigation_directions, location: true, score: 10, weapons: 10) }

  describe ".has_fight" do
    it "should return false" do
      expect(room.has_fight?).to eql(false)
    end
  end

  describe ".looted" do
    it "should return false by default" do
      expect(room.looted).to eql(false)
    end

    it "should return true when it is looted by player" do
      current_tested_room = room
      current_tested_room.looted_by_player
      expect(current_tested_room.looted).to eql(true)
    end
  end

  describe ".navigation_choices" do
    it "should return the keys of the given navigation_directions field in an array" do
      expect(room.navigation_choices.sort).to eql(navigation_directions.keys.sort)
    end
  end
end
