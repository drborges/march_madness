module MarchMadness
  class Bracket
    attr_reader :code
    attr_accessor :title

    def initialize(code)
      @code = code
    end
  end
end
