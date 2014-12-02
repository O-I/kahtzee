require_relative 'error'

module Kahtzee
  def score(roll, category)
    @roll = roll
    raise BadRollError unless valid_roll?
    self.send(category.to_sym)
  end

  def method_missing(method, *args, &block)
    raise UnknownCategoryError
  end

  private

  def valid_roll?
    @roll.size == 5 && (@roll - [*1..6]).empty?
  end

  def kahtzee
    five_of_a_kind? ? 50 : 0
  end

  def chance
    @roll.reduce(:+)
  end

  def five_of_a_kind?
    @roll.uniq.size == 1
  end
end