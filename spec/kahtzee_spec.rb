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
  end
end