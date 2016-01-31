require 'rails_helper'

RSpec.describe ReviewAssignment, type: :model do
  it { is_expected.to belong_to :pull_request }
  it { is_expected.to belong_to :team_membership }
  it { is_expected.to have_one :user }

  it { is_expected.to validate_presence_of :pull_request }
  it { is_expected.to validate_presence_of :team_membership }

  describe '#assignee_handle' do
    let(:review_assignment) { FactoryGirl.build(:review_assignment) }

    context 'with user' do
      let(:user) { FactoryGirl.build(:user, handle: 'johnlithgow') }
      before { review_assignment.user = user }

      it 'returns user handle' do
        expect(review_assignment.assignee_handle).to eq 'johnlithgow'
      end
    end

    context 'without user' do
      before { review_assignment.team_membership.handle = 'dextermorgan' }

      it 'returns team membership handle' do
        expect(review_assignment.assignee_handle).to eq 'dextermorgan'
      end
    end
  end
end
