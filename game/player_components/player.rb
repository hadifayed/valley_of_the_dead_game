require_relative "#{File.join(__dir__, '..', 'game_constants')}"
class Player
  attr_reader :score, :weapons

  def initialize(input_taker:)
    @score = 0
    @weapons = 0
    @input_taker = input_taker
  end

  def add_score(added_score)
    @score += added_score
    puts GameConstants::SCORE_ADDED_MSG + @score.to_s
  end

  def add_weapons(added_weapons)
    @weapons += added_weapons
    puts GameConstants::YOUR_ARMY_PREFIX + added_weapons.to_s + GameConstants::WEAPONS_FOUND_MSG + @weapons.to_s
  end

  def choose(choices)
    @input_taker.get_choice(choices)
  end
end
