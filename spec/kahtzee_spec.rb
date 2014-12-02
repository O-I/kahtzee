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
      expect { score([1, 2, 3, 4, 5, 6], 1) }
        .to raise_error Kahtzee::BadRollError
      expect { score([1, 2, 3, 45, 5], 1) }
        .to raise_error Kahtzee::BadRollError
      expect { score([1, 2.5, 3, 3, 5], 1) }
        .to raise_error Kahtzee::BadRollError
      expect { score([1, 2, 2, 6, 6], 1) }
        .not_to raise_error
    end
  end
end