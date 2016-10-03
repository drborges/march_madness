require 'march_madness/seeds'

module MarchMadness
  class Engine
    attr_reader :bracket_mapping, :qualifier_rank, :bracket_size

    def initialize(qualifier_rank)
      @qualifier_rank = qualifier_rank
      @bracket_size = qualifier_rank.size
      @bracket_seed = MarchMadness::SEEDS[@bracket_size]
      @bracket_mapping = set_up_bracket_mapping(qualifier_rank)
    end

    def initial_matchups(region:)
      possible_matchups(region: region, round: 1)
    end

    def possible_matchups(region:, round:)
      ranks = @bracket_mapping[region]
      @bracket_seed[round].map do |matchups|
        matchups.map { |rank| ranks[rank-1] }
      end
    end

    def total_rounds
      @total_rounds ||= @bracket_seed.count + 2 # semifinal + final rounds
    end

    private

    def set_up_bracket_mapping(qualifier_rank)
      mapping = [
        [], # top-left region
        [], # top-right region
        [], # bottom-right region
        [], # bottom-left region
      ]

      rank = -1
      while rank < @bracket_size-1
        mapping.map! { |region_ranks| region_ranks << qualifier_rank[rank += 1] }
        mapping.reverse!
      end

      mapping
    end
  end
end
