require 'rails_helper'

RSpec.describe 'team_memberships/new', type: :view do
  let(:team) { FactoryGirl.create(:team) }
  before(:each) do
    @team = assign(:team, team)
    @team_membership = assign(:team_membership, team.team_memberships.build)
  end

  it 'renders the edit team_membership form' do
    render

    assert_select(
      'form[action=?][method=?]',
      team_team_memberships_path(@team),
      'post') do
      assert_select(
        'input#team_membership_handle[name=?]', 'team_membership[handle]'
      )
    end
  end
end
