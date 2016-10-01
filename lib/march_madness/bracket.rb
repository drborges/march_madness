module MarchMadness
  class Bracket
    attr_reader :code
    attr_accessor :title, :active_date_range, :announcement_date, :round_duration, :allow_byes
    attr_accessor :seeds_function, :score_function, :untie_function

    def initialize(code)
      @code = code
    end

    def seeds
      seeds_function.call
    end

    def compute_score_for(contestant)
      contestant.score = score_function.call(contestant)
    end

    def resolve_tie(match)
      match.winner = untie_function.call(match.first_contestant, match.second_contestant)
    end
  end
end
