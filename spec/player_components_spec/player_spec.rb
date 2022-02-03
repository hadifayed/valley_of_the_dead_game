require_relative "../../game/player_components/player"

describe Player do

  let(:player) { Player.new(input_taker: nil) }

  describe ".add_score" do
    it "should change the player's score" do
      score_before_adding = player.score
      added_score = 10
      player.add_score(added_score)
      expect(player.score).to eql(score_before_adding + added_score)
    end
  end

  describe ".add_weapons" do
    it "should change the player's weapons" do
      weapons_before_adding = player.weapons
      added_weapons = 10
      player.add_weapons(added_weapons)
      expect(player.weapons).to eql(weapons_before_adding + added_weapons)
    end
  end
end
