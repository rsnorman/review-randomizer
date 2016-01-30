require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to belong_to :company }
  it { is_expected.to belong_to :leader }
  it { is_expected.to have_and_belong_to_many :repos }
  it { is_expected.to have_many :team_memberships }
  it { is_expected.to have_many :users }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :leader }
  it { is_expected.to validate_presence_of :company }

  describe '#team_mates_for' do
    let!(:user) { FactoryGirl.create(:user) }
    let(:user_team_membership) do
      FactoryGirl.create(:team_membership, user: user)
    end
    let(:team_mate_membership) do
      FactoryGirl.create(:team_membership, user: FactoryGirl.create(:user))
    end
    let(:team) { FactoryGirl.create(:team) }

    before do
      team.team_memberships << user_team_membership
      team.team_memberships << team_mate_membership
    end

    it 'returns other team memberships' do
      expect(team.team_mates_for(user))
        .to include team_mate_membership
    end

    it 'doesn\'t return the user\'s team membership' do
      expect(team.team_mates_for(user))
        .to_not include user_team_membership
    end
  end
end
