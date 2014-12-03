require 'pry'
require_relative 'lib/kahtzee'

class DiceRoll
  extend Kahtzee

  attr_reader :dice

  def initialize
    @dice = Array.new(5) { [*1..6].sample }
  end
end

puts

10.times do |n|
  test_throw = DiceRoll.new
  puts "*** TEST THROW #{n + 1}: #{test_throw.dice} ***"
  puts "CATEGORY        | SCORE"
  Kahtzee::VALID_CATEGORIES.each do |category|
    padding = ' ' * (15 - category.to_s.length)
    puts "#{category} #{padding}: #{DiceRoll.score(test_throw.dice, category)}"
  end
  puts
end