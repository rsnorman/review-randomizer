require 'rails_helper'

RSpec.describe "team_memberships/show", type: :view do
  let(:team) { FactoryGirl.create(:team) }
  before(:each) do
    @team = assign(:team, team)
    @team_membership =
      assign(:team_membership, FactoryGirl.create(:team_membership, team: team))
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(/Team/)
    expect(rendered).to match(/Name/)
  end
end
