require 'rails_helper'

RSpec.describe "review_assignments/edit", type: :view do
  let(:pull_request) { FactoryGirl.create(:pull_request) }
  let(:review_assignment) do
    FactoryGirl.create(:review_assignment, pull_request: pull_request)
  end

  before(:each) do
    assign(:pull_request, pull_request)
    assign(:review_assignment, review_assignment)
  end

  it "renders the edit review_assignment form" do
    render

    assert_select(
      "form[action=?][method=?]",
      pull_request_review_assignment_path(pull_request, review_assignment),
      "post") do

      assert_select(
        "select#review_assignment_team_membership_id[name=?]",
        "review_assignment[team_membership_id]"
      )
    end
  end
end
