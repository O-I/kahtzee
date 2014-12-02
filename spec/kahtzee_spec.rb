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
      expect { score([1, 2, 2, 6, 6], :chance) }
        .not_to raise_error
    end

    it 'raises an UnknownCategoryError on invalid category input' do
      expect { score([1, 2, 3, 4, 5], :foo) }
        .to raise_error Kahtzee::UnknownCategoryError
      expect { score([1, 2, 3, 4, 5], 'chance') }
        .not_to raise_error
    end

    it 'returns the score of a roll in a given category' do
      expect(score([1, 1, 2, 3, 4], :ones)).to eq 2
      expect(score([2, 3, 4, 5, 6], :ones)).to eq 0
      expect(score([1, 2, 3, 4, 5], :small_straight)).to eq 15
      expect(score([1, 2, 2, 6, 6], :small_straight)).to eq 0
      expect(score([2, 3, 4, 5, 6], :large_straight)).to eq 20
      expect(score([1, 2, 2, 6, 6], :large_straight)).to eq 0
      expect(score([3, 3, 3, 3, 3], :kahtzee)).to eq 50
      expect(score([2, 2, 2, 4, 2], :kahtzee)).to eq 0
      expect(score([1, 2, 3, 4, 5], :chance)).to eq 15
    end
  end
end