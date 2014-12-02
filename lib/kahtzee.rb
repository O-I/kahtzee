require_relative 'error'

module Kahtzee
  def score(roll, category)
    raise BadRollError unless valid_roll? roll
  end

  private

  def valid_roll?(roll)
    roll.size == 5 && (roll - [*1..6]).empty?
  end
end