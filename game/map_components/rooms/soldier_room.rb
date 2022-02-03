require_relative "room"

class SoldierRoom < Room
  def initialize(location:, navigation_directions:, score:, weapons:)
    super(location: location, navigation_directions: navigation_directions, score: score, weapons: weapons)
    @fight_can_be_skipped = true
    @fight_won = false
  end

  def has_fight?
    !@fight_won
  end

  def fight_skipped
    print_fight_skipped_msg
    @fight_can_be_skipped = false
    GameConstants::RETURN_TO_PREIVOUS_ROOM
  end

  def trigger_fight(player_weapons)
    if player_will_win_fight?(player_weapons)
      player_won_fight
    else
      player_lost_fight
    end
  end

  def print_entry_msg
    if has_fight?
      @fight_can_be_skipped ? print_fight_can_be_skipped_msg : print_fight_can_not_be_skipped_msg
    else
      super
    end
  end

  def fight_options
    if @fight_can_be_skipped
      choices = [GameConstants::FIGHT_OPTION, GameConstants::RUN_OPTION]
    else
      choices = [GameConstants::FIGHT_OPTION]
    end
    print_fight_options_msg(choices)
    choices
  end

  private

  def print_fight_options_msg(choices)
    puts GameConstants::FIGHT_OPTIONS_MSG + "(" + choices.join("/") + ")"
  end

  def print_fight_can_be_skipped_msg
    puts GameConstants::VALLEY_OF_THE_DEAD_PREFIX + weapons.to_s + GameConstants::FIGHT_CAN_BE_SKIPPED_MSG
  end

  def print_fight_can_not_be_skipped_msg
    puts GameConstants::VALLEY_OF_THE_DEAD_PREFIX + weapons.to_s + GameConstants::FIGHT_CAN_NOT_BE_SKIPPED_MSG
  end

  def print_fight_skipped_msg
    puts GameConstants::FIGHT_SKIPPED_MSG
  end

  def player_won_fight
    puts GameConstants::FIGHT_WON_MSG
    @fight_won = true
    GameConstants::FIGHT_WON
  end

  def player_lost_fight
    puts GameConstants::FIGHT_LOST_MSG
    GameConstants::FIGHT_LOST
  end

  def player_will_win_fight?(player_weapons)
    player_weapons > @weapons
  end
end
