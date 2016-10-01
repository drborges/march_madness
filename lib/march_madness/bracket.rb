module MarchMadness
  module Bracket
    attr_accessor :code, :title, :active_date_range, :announcement_date
    attr_accessor :round_duration, :allow_byes
    attr_accessor :seeds_function, :score_function, :untie_function

    def qualidier_seeds
      seeds_function.call
    end

    def compute_score_for(participant)
      participant.score = score_function.call(participant)
    end

    def resolve_tie(match)
      match.winner = untie_function.call(match.first_participant, match.second_participant)
    end
  end
end
