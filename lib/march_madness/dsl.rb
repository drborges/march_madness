require 'march_madness/bracket'

module MarchMadness
  @@definitions = {}

  def self.define(&block)
    definition_proxy = DefinitionProxy.new
    definition_proxy.instance_eval(&block)
    duplicated_definitions = @@definitions.keys & definition_proxy.brackets.keys
    if duplicated_definitions.present?
      raise DuplicatedDefinition, "Brackets #{duplicated_definitions} were already defined by another define block."
    else
      @@definitions = @@definitions.merge(definition_proxy.brackets)
    end
  end

  def self.define!(&block)
    definition_proxy = DefinitionProxy.new
    definition_proxy.instance_eval(&block)
    @@definitions = @@definitions.merge(definition_proxy.brackets)
  end

  def self.definitions
    @@definitions
  end

  class DuplicatedDefinition < StandardError; end

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

    def active(from_date:, until_date:)
      @bracket.active_date_range = from_date..until_date
    end

    def announcement_date(date)
      @bracket.announcement_date = date
    end

    def round_duration(duration)
      @bracket.round_duration = duration
    end

    def allow_byes(flag)
      @bracket.allow_byes = flag
    end

    def seeds_with(callable)
      @bracket.seeds_function = callable
    end

    def score_with(callable)
      @bracket.score_function = callable
    end

    def untie_with(callable)
      @bracket.untie_function = callable
    end
  end
end
