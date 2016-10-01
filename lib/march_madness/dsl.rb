require 'march_madness/bracket'

module MarchMadness
  def self.define(&block)
    definition_proxy = DefinitionProxy.new
    definition_proxy.instance_eval(&block)
    definition_proxy.brackets
  end

  class DefinitionProxy < BasicObject
    attr_reader :brackets

    def initialize
      @brackets = {}
    end

    def bracket(code, &block)
      bracket_proxy = BracketProxy.new code
      bracket_proxy.instance_eval(&block)
      @brackets[code] = bracket_proxy.bracket
    end
  end

  class BracketProxy < BasicObject
    attr_reader :bracket

    def initialize(code)
      @bracket = Bracket.new code
    end

    def title(title)
      @bracket.title = title
    end
  end
end
