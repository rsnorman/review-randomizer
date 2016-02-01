require 'rails_helper'

RSpec.describe PullRequestsHelper, type: :helper do
  describe '#author_name' do
    context 'with user as author' do
      let(:user) { FactoryGirl.build(:user) }

      it 'returns user name' do
        expect(helper.author_name(user)).to eq user.name
      end
    end

    context 'with team membership as author' do
      let(:team_membership) { FactoryGirl.build(:team_membership) }

      it 'returns team membership handle' do
        expect(helper.author_name(team_membership))
          .to eq "@#{team_membership.handle}"
      end
    end
  end
end
