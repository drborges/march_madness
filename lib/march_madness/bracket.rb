module MarchMadness
  module Bracket
    attr_accessor :code, :title, :active_date_range, :announcement_date
    attr_accessor :round_duration, :allow_byes
    attr_accessor :seeds_function, :score_function, :untie_function

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
