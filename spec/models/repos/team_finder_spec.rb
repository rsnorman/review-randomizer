require 'rails_helper'

RSpec.describe Repos::TeamFinder do
  let(:repo)    { FactoryGirl.create(:repo) }
  let(:team)    { FactoryGirl.create(:team) }
  let(:user)    { FactoryGirl.create(:user) }
  let(:finder)  { described_class.new(repo) }

  before do
    repo.teams << team
    team.users << user
  end

  describe '#for_team_member' do
    it 'returns the team that is tied to the repo for the user' do
      expect(finder.for_team_member(user)).to eq team
    end

    context 'with no teams tied to the repo' do
      before { repo.teams.delete(team) }

      it 'returns nil' do
        expect(finder.for_team_member(user)).to be_nil
      end
    end

    context 'with multiple teams tied to the repo' do
      let(:team2) { FactoryGirl.create(:team) }

      before do
        repo.teams << team2
        team2.users << user
      end

      it 'raises an exception' do
        expect { finder.for_team_member(user) }.to raise_exception(
          Repos::TeamFinder::RepoTeamConflict,
          'Multiple teams exist for the repo'
        )
      end
    end

    context 'with unregistered user' do
      let(:team_membership) { FactoryGirl.create(:team_membership, team: team) }

      it 'returns the team that is tied to the team membership' do
        expect(finder.for_team_member(team_membership)).to eq team
      end
    end
  end

  describe '#for_team_member!' do
    it 'returns the team that is tied to the repo for the user' do
      expect(finder.for_team_member!(user)).to eq team
    end

    context 'with no teams tied to the repo' do
      before { repo.teams.delete(team) }

      it 'returns nil' do
        expect { finder.for_team_member!(user) }.to raise_exception(
          described_class::RepoTeamMismatch,
          'User not on team tied to pull request\'s repo'
        )
      end
    end
  end
end
