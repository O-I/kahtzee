module Kahtzee
  class BadRollError < StandardError
    def to_s
      'Rolls must be an array of length 5 ' \
      'with integer values in the range 1..6'
    end
  end

  class UnknownCategoryError < StandardError
    def to_s
      'Invalid Kahtzee category'
    end
  end
end