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

  def chance
    @roll.reduce(:+)
  end
end