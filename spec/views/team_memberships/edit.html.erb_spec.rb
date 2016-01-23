require 'rails_helper'

RSpec.describe "team_memberships/edit", type: :view do
  before(:each) do
    @team_membership = assign(:team_membership, TeamMembership.create!())
  end

  it "renders the edit team_membership form" do
    render

    assert_select "form[action=?][method=?]", team_membership_path(@team_membership), "post" do
    end
  end
end
