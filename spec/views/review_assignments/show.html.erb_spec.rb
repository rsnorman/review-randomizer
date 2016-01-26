require 'rails_helper'

RSpec.describe "review_assignments/show", type: :view do
  let(:pull_request) { FactoryGirl.create(:pull_request) }
  let(:review_assignment) do
    FactoryGirl.create(:review_assignment, pull_request: pull_request)
  end
  before(:each) do
    assign(:pull_request, pull_request)
    assign(:review_assignment, review_assignment)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(CGI.escape_html(pull_request.title))
    expect(rendered).to match("@#{review_assignment.team_membership.handle}")
  end
end
