require 'rails_helper'

RSpec.describe 'team_memberships/edit', type: :view do
  let(:team) { FactoryGirl.create(:team) }
  before(:each) do
    @team = assign(:team, team)
    @team_membership =
      assign(:team_membership, FactoryGirl.create(:team_membership, team: team))
  end

  it 'renders the edit team_membership form' do
    render

    assert_select(
      'form[action=?][method=?]',
      team_team_membership_path(@team, @team_membership),
      'post') do
      assert_select(
        'input#team_membership_handle[name=?]', 'team_membership[handle]'
      )
      assert_select(
        'select#team_membership_user_id[name=?]', 'team_membership[user_id]'
      )
    end
  end
end
