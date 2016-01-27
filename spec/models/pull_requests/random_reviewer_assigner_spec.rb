require 'rails_helper'

RSpec.describe PullRequests::RandomReviewerAssigner do
  describe '#assign_reviewers' do
    let(:pull_request) { FactoryGirl.create(:pull_request) }
    let(:reviewer1)    { pull_request.author }
    let(:reviewer2)    { FactoryGirl.create(:user) }
    let(:reviewer3)    { FactoryGirl.create(:user) }
    let(:team)         { FactoryGirl.create(:team) }

    before do
      [reviewer1, reviewer2, reviewer3].each do |reviewer|
        FactoryGirl.create(:team_membership, user: reviewer, team: team)
      end
    end

    let(:assigner) { described_class.new(pull_request, 2) }

    it 'assigns two random reviewers' do
      assigner.assign_reviewers(TeamMembership.all)
      expect(pull_request.users.to_a.sort_by(&:id))
        .to eq([reviewer2, reviewer3])
    end

    context 'when initialized with different assignment count' do
      let(:assigner) { described_class.new(pull_request, 1) }

      it 'assigns only 1 reviewer' do
        expect { assigner.assign_reviewers(TeamMembership.all) }
          .to change(pull_request.users, :count).by 1
      end
    end
  end
end
