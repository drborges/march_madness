require 'spec_helper'

describe MarchMadness do
  describe '#define' do
    subject do
      MarchMadness.define do
        bracket :bracket_1 do; end
        bracket :bracket_2 do; end
        bracket :bracket_3 do; end
      end

      MarchMadness.define do
        bracket :bracket_4 do; end
        bracket :bracket_5 do; end
      end

      MarchMadness.definitions
    end

    it { is_expected.to have_exactly(5).defined_brackets }
    it { is_expected.to have_key(:bracket_1) }
    it { is_expected.to have_key(:bracket_2) }
    it { is_expected.to have_key(:bracket_3) }
    it { is_expected.to have_key(:bracket_4) }
    it { is_expected.to have_key(:bracket_5) }
  end

  describe "#bracket" do
    subject(:bracket_1) do
      MarchMadness.define do
        bracket :bracket_1 do
          title 'Bracket Title'
          active from_date: Fixtures::START_DATE, until_date: Fixtures::END_DATE
          announcement_date Fixtures::ANNOUNCEMENT_DATE
          round_duration 1.week
          allow_byes true

          seeds_with Fixtures::SEEDS_FUNCTION
          score_with Fixtures::SCORE_FUNCTION
          untie_with Fixtures::UNTIE_FUNCTION
        end
      end

      MarchMadness.definitions[:bracket_1]
    end

    its(:code) { is_expected.to eq :bracket_1 }
    its(:active_date_range) { is_expected.to eq(Fixtures::START_DATE..Fixtures::END_DATE) }
    its(:announcement_date) { is_expected.to eq Fixtures::ANNOUNCEMENT_DATE }
    its(:round_duration) { is_expected.to eq 1.week }
    its(:allow_byes) { is_expected.to be_truthy }
    its(:seeds_function) { is_expected.to eq Fixtures::SEEDS_FUNCTION }
    its(:score_function) { is_expected.to eq Fixtures::SCORE_FUNCTION }
    its(:untie_function) { is_expected.to eq Fixtures::UNTIE_FUNCTION }
  end
end
