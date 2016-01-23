require 'rails_helper'

RSpec.describe "team_memberships/new", type: :view do
  before(:each) do
    assign(:team_membership, TeamMembership.new())
  end

  it "renders new team_membership form" do
    render

    assert_select "form[action=?][method=?]", team_memberships_path, "post" do
    end
  end
end
