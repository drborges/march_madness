require 'spec_helper'

describe MarchMadness::Engine do
  let(:qualifier_rank) { (101..132).to_a.map{|id| "id: #{id}"} }
  subject(:engine) { MarchMadness::Engine.new qualifier_rank }

  its(:bracket_size) { is_expected.to eq qualifier_rank.size }

  describe "#bracket_mapping" do
    subject(:bracket_mapping) { engine.bracket_mapping }
    it { is_expected.to have(4).quadrants }

    context "with top-left region setup" do
      subject { engine.bracket_mapping[0] }
      it { is_expected.to match_array ['id: 101', 'id: 108', 'id: 109', 'id: 116', 'id: 117', 'id: 124', 'id: 125', 'id: 132'] }
    end

    context "with top-right region setup" do
      subject { engine.bracket_mapping[1] }
      it { is_expected.to match_array ['id: 102', 'id: 107', 'id: 110', 'id: 115', 'id: 118', 'id: 123', 'id: 126', 'id: 131'] }
    end

    context "with bottom-right region setup" do
      subject { engine.bracket_mapping[2] }
      it { is_expected.to match_array ['id: 103', 'id: 106', 'id: 111', 'id: 114', 'id: 119', 'id: 122', 'id: 127', 'id: 130'] }
    end

    context "with bottom-left region setup" do
      subject { engine.bracket_mapping[3] }
      it { is_expected.to match_array ['id: 104', 'id: 105', 'id: 112', 'id: 113', 'id: 120', 'id: 121', 'id: 128', 'id: 129'] }
    end
  end

  context "matchups" do
    let(:top_left_round_1_matchups) {[['id: 101', 'id: 132'], ['id: 116', 'id: 117'], ['id: 109', 'id: 124'], ['id: 108', 'id: 125']]}
    let(:top_right_round_1_matchups) {[['id: 102', 'id: 131'], ['id: 115', 'id: 118'], ['id: 110', 'id: 123'], ['id: 107', 'id: 126']]}
    let(:bottom_right_round_1_matchups) {[['id: 103', 'id: 130'], ['id: 114', 'id: 119'], ['id: 111', 'id: 122'], ['id: 106', 'id: 127']]}
    let(:bottom_left_round_1_matchups) {[['id: 104', 'id: 129'], ['id: 113', 'id: 120'], ['id: 112', 'id: 121'], ['id: 105', 'id: 128']]}

    describe "#initial_matchups" do
      context "for top-left region" do
        subject { engine.initial_matchups region: 0 }
        it { is_expected.to match_array top_left_round_1_matchups }
      end

      context "for top-right region" do
        subject { engine.initial_matchups region: 1 }
        it { is_expected.to match_array top_right_round_1_matchups }
      end

      context "for bottom-right region" do
        subject { engine.initial_matchups region: 2 }
        it { is_expected.to match_array bottom_right_round_1_matchups }
      end

      context "for bottom-left region" do
        subject { engine.initial_matchups region: 3 }
        it { is_expected.to match_array bottom_left_round_1_matchups }
      end
    end

    describe "#possible_matchups" do
      context "for top-left region round 1" do
        subject { engine.possible_matchups region: 0, round: 1 }
        it { is_expected.to match_array top_left_round_1_matchups }
      end

      context "for top-right region round 1" do
        subject { engine.possible_matchups region: 1, round: 1 }
        it { is_expected.to match_array top_right_round_1_matchups }
      end

      context "for bottom-right region round 1" do
        subject { engine.possible_matchups region: 2, round: 1 }
        it { is_expected.to match_array bottom_right_round_1_matchups }
      end

      context "for bottom-left region round 1" do
        subject { engine.possible_matchups region: 3, round: 1 }
        it { is_expected.to match_array bottom_left_round_1_matchups }
      end
    end
  end
end
