require 'spec_helper'

describe MarchMadness do
  it 'has a version number' do
    expect(MarchMadness::VERSION).not_to be nil
  end

  describe '#define' do
    context "with multiple definition blocks" do
      subject do
        MarchMadness.define! do
          bracket :bracket_1, as: Fixtures::CustomBracket do; end
          bracket :bracket_2, as: Fixtures::CustomBracket do; end
          bracket :bracket_3, as: Fixtures::CustomBracket do; end
        end

        MarchMadness.define! do
          bracket :bracket_4, as: Fixtures::CustomBracket do; end
          bracket :bracket_5, as: Fixtures::CustomBracket do; end
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

    context "with overriden definitions" do
      subject do
        MarchMadness.define! do
          bracket :bracket_1, as: Fixtures::CustomBracket do; end
        end

        MarchMadness.define! do
          bracket :bracket_1, as: Fixtures::CustomBracket do; end
        end

        MarchMadness.definitions
      end

      before(:all) { MarchMadness.definitions.clear }
      it { is_expected.to have_exactly(1).defined_bracket }
      it { is_expected.to have_key(:bracket_1) }
    end

    context "with duplicated definitions" do
      before(:all) { MarchMadness.definitions.clear }
      it { expect {
          MarchMadness.define do
            bracket :bracket_1, as: Fixtures::CustomBracket do; end
            bracket :bracket_2, as: Fixtures::CustomBracket do; end
          end

          MarchMadness.define do
            bracket :bracket_1, as: Fixtures::CustomBracket do; end
            bracket :bracket_2, as: Fixtures::CustomBracket do; end
          end
        }.to raise_error(MarchMadness::DuplicatedDefinition, "Brackets [:bracket_1, :bracket_2] were already defined by another define block.")
      }
    end
  end

  describe "#bracket" do
    context "with bracket configuration" do
      subject(:bracket_1) do
        MarchMadness.define! do
          bracket :bracket_1, as: Fixtures::CustomBracket do
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

      it { is_expected.to be_kind_of MarchMadness::Bracket }
      its(:code) { is_expected.to eq :bracket_1 }
      its(:active_date_range) { is_expected.to eq(Fixtures::START_DATE..Fixtures::END_DATE) }
      its(:announcement_date) { is_expected.to eq Fixtures::ANNOUNCEMENT_DATE }
      its(:round_duration) { is_expected.to eq 1.week }
      its(:allow_byes) { is_expected.to be_truthy }
      its(:seeds_function) { is_expected.to eq Fixtures::SEEDS_FUNCTION }
      its(:score_function) { is_expected.to eq Fixtures::SCORE_FUNCTION }
      its(:untie_function) { is_expected.to eq Fixtures::UNTIE_FUNCTION }
    end

    context "with missing bracket type" do
      subject(:bracket_1) do
        it do
          expect do
            MarchMadness.define! do
              bracket :bracket_1 do
              end
            end
          end.to raise_error(MissingBracketType, "You must provide a bracket implementation type")
        end
      end
    end
  end
end
