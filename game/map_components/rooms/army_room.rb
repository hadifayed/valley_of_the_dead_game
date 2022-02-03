require_relative "soldier_room"

class ArmyRoom < SoldierRoom

  private

  def player_won_fight
    super
    GameConstants::LEVEL_FINISHED
  end
end
