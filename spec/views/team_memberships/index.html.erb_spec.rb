require 'rails_helper'

RSpec.describe "team_memberships/index", type: :view do
  before(:each) do
    assign(:team_memberships, [
      TeamMembership.create!(),
      TeamMembership.create!()
    ])
  end

  it "renders a list of team_memberships" do
    render
  end
end
