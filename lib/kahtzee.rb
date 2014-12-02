require_relative 'error'

module Kahtzee
  attr_reader :roll
  VALID_CATEGORIES = [:ones, :twos, :threes, :fours, :fives, :sixes,
                      :pair, :two_pairs, :three_of_a_kind, :four_of_a_kind,
                      :small_straight, :large_straight, :full_house,
                      :kahtzee, :chance]

  def score(roll, category)
    @roll = roll
    raise BadRollError unless valid_roll?
    raise UnknownCategoryError unless VALID_CATEGORIES.include? category.to_sym
    self.send(category.to_sym)
  end

  private

  def valid_roll?
    roll.size == 5 && (roll - [*1..6]).empty?
  end

  def kahtzee
    five_of_a_kind? ? 50 : 0
  end

  def chance
    roll.reduce(:+)
  end

  def five_of_a_kind?
    roll.uniq.size == 1
  end
end