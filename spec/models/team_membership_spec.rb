require 'rails_helper'

RSpec.describe TeamMembership, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :team }
  it { is_expected.to have_many :review_assignments }

  it { is_expected.to validate_presence_of :handle }
  it { is_expected.to validate_presence_of :user }

  describe '.only_team_mates' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_team_membership) do
      FactoryGirl.create(:team_membership, user: user)
    end
    let!(:team_mate_membership) do
      FactoryGirl.create(:team_membership, user: FactoryGirl.create(:user))
    end

    it 'returns other team memberships' do
      expect(described_class.only_team_mates(user))
        .to include team_mate_membership
    end

    it 'doesn\'t return the user\'s team membership' do
      expect(described_class.only_team_mates(user))
        .to_not include user_team_membership
    end
  end
end
