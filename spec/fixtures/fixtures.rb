require 'march_madness/bracket'

module Fixtures
  SEEDS_FUNCTION = ->{ 'seeds function' }
  SCORE_FUNCTION = ->{ 'score function' }
  UNTIE_FUNCTION = ->{ 'untie function' }
  START_DATE = Date.new(2016, 9, 30)
  END_DATE = Date.new(2016, 10, 25)
  ANNOUNCEMENT_DATE = Date.new(2016, 10, 26)

  class InvalidBracketType
  end

  class Bracket
    include MarchMadness::Bracket
  end
end
