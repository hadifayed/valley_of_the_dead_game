require_relative "base_level"
require_relative "level2"

class Level1 < BaseLevel
  def map_description
    [["empty@@10@@10" , "empty@@10@@10", "empty@@10@@10",        nil        ],
     [      nil       , "empty@@20@@10", "empty@@20@@10", "soldier@@200@@10"],
     [      nil       , "empty@@20@@10", "empty@@20@@10", "soldier@@100@@10"],
     [      nil       ,      nil       ,      nil       ,  "army@@400@@10"  ]]
  end

  def starting_point
    [0,0]
  end

  def print_finishing_msg
    puts GameConstants::LEVEL1_FINISHING_MSG
    puts GameConstants::ARMY_ENTERED_NEW_LEVEL
  end

  def next_level
    Level2.instance
  end
end
