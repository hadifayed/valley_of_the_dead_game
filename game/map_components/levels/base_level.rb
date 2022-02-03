require 'singleton'
require_relative "#{File.join(__dir__, '..', '..', 'game_constants')}"

class BaseLevel
  include Singleton
  def has_next_level?
    !next_level.nil?
  end

  def next_level
    nil
  end
end
