require 'rails_helper'

RSpec.describe 'team_memberships/index', type: :view do
  let(:team) { FactoryGirl.create(:team) }
  let(:team_membership1) { FactoryGirl.create(:team_membership, team: team) }
  let(:team_membership2) do
    FactoryGirl.create(:team_membership, :with_user, team: team)
  end
  before(:each) do
    assign(:team, team)
    assign(:team_memberships, [team_membership1, team_membership2])
  end

  it 'renders a list of team_memberships' do
    render
    assert_select 'tr>td', text: "@#{team_membership1.handle}", count: 1
    assert_select 'tr>td', text: team_membership2.user.name, count: 1
  end
end
