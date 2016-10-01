require 'spec_helper'

describe MarchMadness do
  describe '#define' do
    subject do
      MarchMadness.define do
        bracket :bracket_1 do; end
        bracket :bracket_2 do; end
        bracket :bracket_3 do; end
      end
    end

    it { is_expected.to have_exactly(3).defined_brackets }
    it { is_expected.to have_key(:bracket_1) }
    it { is_expected.to have_key(:bracket_2) }
    it { is_expected.to have_key(:bracket_3) }
  end
end
