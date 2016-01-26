require 'rails_helper'

RSpec.describe "review_assignments/new", type: :view do
  let(:pull_request) { FactoryGirl.create(:pull_request) }
  let(:review_assignment) do
    FactoryGirl.build(
      :review_assignment,
      pull_request: pull_request,
      team_membership: nil
    )
  end

  before(:each) do
    assign(:pull_request, pull_request)
    assign(:review_assignment, review_assignment)
  end

  it "renders the new review_assignment form" do
    render

    assert_select(
      "form[action=?][method=?]",
      pull_request_review_assignments_path(pull_request),
      "post") do

      assert_select(
        "select#review_assignment_team_membership_id[name=?]",
        "review_assignment[team_membership_id]"
      )
    end
  end
end
