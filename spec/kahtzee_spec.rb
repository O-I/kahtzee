require_relative 'spec_helper'
require_relative '../lib/kahtzee'

describe 'Kahtzee' do
  before(:each) { extend Kahtzee }

  it 'has a score method' do
    expect(method(:score))
  end
end