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
    valid_size? && valid_values?
  end

  def valid_size?
    roll.size == 5
  end

  def valid_values?
    (roll - [*1..6]).empty?
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
    results = frequency.select { |k, v| v > 1 }
    results.keys.reduce(:+) * 2 if results.size == 2
  end

  def three_of_a_kind
    of_a_kind 3
  end

  def four_of_a_kind
    of_a_kind 4
  end

  def of_a_kind(kind_count)
    frequency.detect { |_, die_count| die_count == kind_count }.to_a.reduce(:*)
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
    sum if pair? && three_of_a_kind? && !five_of_a_kind?
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
    sum
  end

  def sum
    roll.reduce(:+)
  end

  def frequency_distribution
    Hash[order raw_frequency]
  end

  def raw_frequency
    roll.reduce(Hash.new(0)) { |freq, die| freq[die] += 1; freq }
  end

  def order(freq)
    freq.sort_by { |die_value, die_count| [-die_count, -die_value] }
  end
end