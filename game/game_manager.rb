require_relative "game_constants"

class GameManager
  attr_reader :player, :map, :current_room

  def initialize(player:, map:, current_room:)
    @player = player
    @map = map
    @current_room = current_room
  end

  def move_player_to_current_room
    return GameConstants::PLAYER_EXITED if current_room.nil?
    current_room.print_entry_msg
    if current_room.has_fight?
      player_enter_fight_room
    else
      player_loot_current_room_if_not_looted
      player_navigate_from_current_room
    end
  end

  def player_will_continue_to_play?(player_previous_action_response)
    if end_game?(player_previous_action_response)
      print_game_exit_msg
      false
    elsif player_finished_current_level?(player_previous_action_response)
      map.move_to_next_level
      set_current_room_from_map
    else
      map.move_from_current_room(player_previous_action_response)
      set_current_room_from_map
    end
  end

  private

  def set_current_room_from_map
    @current_room = map.current_room
  end

  def player_enter_fight_room
    choice = player.choose(current_room.fight_options)
    return choice if player_exited?(choice)
    if player_will_fight?(choice)
      fight_result = current_room.trigger_fight(player.weapons)
      if fight_won?(fight_result)
        player_loot_current_room_if_not_looted
        player_finished_current_level?(fight_result) ? GameConstants::LEVEL_FINISHED : player_navigate_from_current_room
      else
        GameConstants::FIGHT_LOST
      end
    else
      current_room.fight_skipped
    end
  end

  def player_loot_current_room_if_not_looted
    return if current_room.looted
    player.add_weapons(current_room.weapons) if current_room.weapons > 0
    player.add_score(current_room.score) if current_room.score > 0
    current_room.looted_by_player
  end

  def player_navigate_from_current_room
    player.choose(current_room.navigation_choices)
  end

  def print_game_exit_msg
    puts GameConstants::GAME_EXIT_MSG
  end

  def end_game?(player_response)
    player_exited?(player_response) || player_response == GameConstants::FIGHT_LOST
  end

  def player_exited?(player_response)
    player_response == GameConstants::PLAYER_EXITED
  end

  def player_finished_current_level?(player_response)
    player_response == GameConstants::LEVEL_FINISHED
  end

  def player_will_fight?(player_response)
    player_response == GameConstants::FIGHT_OPTION
  end

  def fight_won?(player_response)
    player_response == GameConstants::FIGHT_WON || player_finished_current_level?(player_response)
  end
end
