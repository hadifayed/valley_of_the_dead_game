require_relative "#{File.join(__dir__, '..', 'game_constants')}"
class InputTaker
  def initialize(input_handler: $stdin)
    @input_handler = input_handler
  end

  def get_choice(choices)
    user_choice = get_input_from_user
    times_user_gave_choice = 1
    until choice_is_valid?(choices, user_choice)
      return played_exceeded_choices_trial if times_user_gave_choice >= GameConstants::CHOICE_TRIAL
      puts GameConstants::INVALID_CHOICE_MSG
      times_user_gave_choice += 1
      user_choice = get_input_from_user
    end
    user_choice
  end

  private

  def played_exceeded_choices_trial
    puts GameConstants::EXCEEDED_CHOICES_TRIALS
    GameConstants::PLAYER_EXITED
  end

  def get_input_from_user
    print GameConstants::INPUT_TAKING_MSG
    @input_handler.gets.chomp.downcase.to_sym
  end

  def choice_is_valid?(valid_choices, user_choice)
    if user_choice == GameConstants::PLAYER_EXITED || valid_choices.include?(user_choice)
      true
    else
      false
    end
  end
end
