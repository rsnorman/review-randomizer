require 'rails_helper'

RSpec.describe TeamMembershipsHelper, type: :helper do
  describe '#member_name' do
    context 'without user' do
      let(:membership) do
        FactoryGirl.build(:team_membership, handle: 'ryannorman')
      end

      it 'returns membership handle' do
        expect(helper.member_name(membership)).to eq '@ryannorman'
      end
    end

    context 'with user' do
      let(:user) { FactoryGirl.build(:user, name: 'Ryan Norman') }
      let(:membership) { FactoryGirl.build(:team_membership, user: user) }

      it 'returns user name' do
        expect(helper.member_name(membership)).to eq 'Ryan Norman'
      end
    end
  end
end
