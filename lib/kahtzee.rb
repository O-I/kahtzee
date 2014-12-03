require_relative 'error'

module Kahtzee
  attr_reader :roll, :frequency
  VALID_CATEGORIES = [:ones, :twos, :threes, :fours, :fives, :sixes,
                      :pair, :two_pairs, :three_of_a_kind, :four_of_a_kind,
                      :small_straight, :large_straight, :full_house,
                      :kahtzee, :chance]

  def score(roll, category)
    @roll = roll
    raise BadRollError unless valid_roll?
    raise UnknownCategoryError unless VALID_CATEGORIES.include? category.to_sym
    @frequency = frequency_distribution
    self.send(category.to_sym) || 0
  end

  private

  def valid_roll?
    roll.size == 5 && (roll - [*1..6]).empty?
  end

  def ones
    tally 1
  end

  def twos
    tally 2
  end

  def threes
    tally 3
  end

  def fours
    tally 4
  end

  def fives
    tally 5
  end

  def sixes
    tally 6
  end

  def pair
    of_a_kind 2
  end

  def two_pairs
    multiplicands = frequency.select { |k, v| v > 1 }
    multiplicands.keys.reduce(:+) * 2 if multiplicands.size == 2
  end

  def three_of_a_kind
    of_a_kind 3
  end

  def four_of_a_kind
    of_a_kind 4
  end

  def of_a_kind(kind_count)
    multiplicands = frequency.detect { |_, v| v == kind_count }
    multiplicands.reduce(:*) if multiplicands
  end

  def tally(die_value)
    roll.count(die_value) * die_value
  end

  def small_straight
    15 if roll == [*1..5]
  end

  def large_straight
    20 if roll == [*2..6]
  end

  def full_house
    chance if pair? && three_of_a_kind? && !five_of_a_kind?
  end

  def kahtzee
    50 if five_of_a_kind?
  end

  def pair?
    frequency.values.include? 2
  end

  def three_of_a_kind?
    frequency.values.include? 3
  end

  def four_of_a_kind?
    frequency.values.include? 4
  end

  def five_of_a_kind?
    frequency.values.include? 5
  end

  def chance
    roll.reduce(:+)
  end

  def frequency_distribution
    roll.reduce(Hash.new(0)) do |hash, element|
      hash[element] += 1
      hash
    end.sort_by { |k, v| [-v, -k] }.to_h
  end
end