require 'rails_helper'

RSpec.describe "team_memberships/show", type: :view do
  before(:each) do
    @team_membership = assign(:team_membership, TeamMembership.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
