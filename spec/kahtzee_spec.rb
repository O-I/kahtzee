require_relative 'spec_helper'
require_relative '../lib/kahtzee'

describe 'Kahtzee' do
  before(:each) { extend Kahtzee }

  context '.score' do

    it 'is defined' do
      expect(method(:score))
    end

    it 'takes two required parameters named role and category' do
      parameters = method(:score).parameters
      expect(parameters.size).to eq 2
      expect(parameters.first).to eq [:req, :roll]
      expect(parameters.last).to eq [:req, :category]
    end

    it 'raises a BadRollError on invalid roll input' do
      expect { score([1, 2, 3, 4, 5, 6], :chance) }
        .to raise_error Kahtzee::BadRollError
      expect { score([1, 2, 3, 45, 5], :chance) }
        .to raise_error Kahtzee::BadRollError
      expect { score([1, 2.5, 3, 3, 5], :chance) }
        .to raise_error Kahtzee::BadRollError
      expect { score(['one', :two, [], {}, -5], :chance) }
        .to raise_error Kahtzee::BadRollError
      expect { score(:foo, :chance) }
        .to raise_error Kahtzee::BadRollError
      expect { score([1, 2, 2, 6, 6], :chance) }
        .not_to raise_error
    end

    it 'raises an UnknownCategoryError on invalid category input' do
      expect { score([1, 2, 3, 4, 5], :foo) }
        .to raise_error Kahtzee::UnknownCategoryError
      expect { score([1, 2, 3, 4, 5], 'sum') }
        .to raise_error Kahtzee::UnknownCategoryError
      expect { score([1, 2, 3, 4, 5], :sixes) }
        .not_to raise_error
      expect { score([1, 2, 3, 4, 5], 'chance') }
        .not_to raise_error
    end

    it 'returns the score of a roll in a given category' do
      expect(score([1, 1, 2, 3, 4], :ones)).to eq 2
      expect(score([2, 3, 4, 5, 6], :ones)).to eq 0

      expect(score([2, 2, 2, 4, 5], :twos)).to eq 6
      expect(score([1, 3, 4, 5, 6], :twos)).to eq 0

      expect(score([3, 1, 4, 3, 3], :threes)).to eq 9
      expect(score([1, 2, 4, 5, 6], :threes)).to eq 0

      expect(score([2, 4, 6, 4, 2], :fours)).to eq 8
      expect(score([6, 5, 3, 2, 1], :fours)).to eq 0

      expect(score([5, 5, 6, 5, 6], :fives)).to eq 15
      expect(score([6, 4, 3, 2, 1], :fives)).to eq 0

      expect(score([6, 6, 5, 6, 6], :sixes)).to eq 24
      expect(score([5, 4, 3, 2, 1], :sixes)).to eq 0

      expect(score([1, 1, 2, 3, 4], :pair)).to eq 2
      expect(score([1, 2, 2, 1, 6], :pair)).to eq 4
      expect(score([1, 2, 3, 4, 5], :pair)).to eq 0

      expect(score([3, 3, 3, 4, 4], :two_pairs)).to eq 14
      expect(score([6, 4, 5, 4, 5], :two_pairs)).to eq 18
      expect(score([1, 1, 2, 3, 3], :two_pairs)).to eq 8
      expect(score([1, 2, 3, 3, 6], :two_pairs)).to eq 0

      expect(score([3, 2, 3, 1, 3], :three_of_a_kind)).to eq 9
      expect(score([1, 2, 3, 3, 2], :three_of_a_kind)).to eq 0

      expect(score([6, 5, 6, 6, 6], :four_of_a_kind)).to eq 24
      expect(score([1, 1, 2, 2, 2], :four_of_a_kind)).to eq 0

      expect(score([1, 2, 3, 4, 5], :small_straight)).to eq 15
      expect(score([1, 2, 2, 6, 6], :small_straight)).to eq 0

      expect(score([2, 3, 4, 5, 6], :large_straight)).to eq 20
      expect(score([1, 2, 2, 6, 6], :large_straight)).to eq 0

      expect(score([2, 2, 3, 3, 3], :full_house)).to eq 13
      expect(score([1, 4, 1, 4, 1], :full_house)).to eq 11
      expect(score([4, 4, 4, 4, 4], :full_house)).to eq 0
      expect(score([1, 2, 1, 2, 3], :full_house)).to eq 0
      expect(score([1, 2, 3, 4, 5], :full_house)).to eq 0

      expect(score([3, 3, 3, 3, 3], :kahtzee)).to eq 50
      expect(score([2, 2, 2, 4, 2], :kahtzee)).to eq 0

      expect(score([1, 2, 3, 4, 5], :chance)).to eq 15
    end
  end
end