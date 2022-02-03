require_relative 'base_level'

class Level2 < BaseLevel
  def map_description
    [["empty@@10@@10"   ,   "empty@@10@@10"  ,   "empty@@10@@10"  ,  "empty@@10@@10"   ,        nil         ],
     [      nil         ,   "empty@@20@@10"  ,  "soldier@@900@@10",   "empty@@20@@10"  , "soldier@@1700@@10"],
     [      nil         , "soldier@@3400@@10",   "empty@@20@@10"  ,  "empty@@20@@10"   ,   "empty@@20@@10"  ],
     ["empty@@20@@10"   ,   "empty@@20@@10"  ,   "empty@@20@@10"  , "soldier@@2000@@10", "soldier@@6000@@10"],
     ["army@@12000@@10" ,        nil         ,        nil         ,       nil          ,  "empty@@20@@10"   ]]
  end

  def starting_point
    [2,3]
  end

  def print_finishing_msg
    puts GameConstants::LEVEL2_FINISHING_MSG
  end
end
