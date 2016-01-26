require 'rails_helper'

RSpec.describe 'review_assignments/index', type: :view do
  let(:pull_request) { FactoryGirl.create(:pull_request) }
  let(:review_assignment1) do
    FactoryGirl.create(:review_assignment, pull_request: pull_request)
  end
  let(:review_assignment2) do
    FactoryGirl.create(
      :review_assignment,
      :with_user,
      pull_request: pull_request
    )
  end

  before(:each) do
    assign(:pull_request, pull_request)
    assign(:review_assignments, [review_assignment1, review_assignment2])
  end

  it 'renders a list of review_assignments' do
    render
    assert_select(
      'tr>td', text: "@#{review_assignment1.team_membership.handle}", count: 1
    )
    assert_select(
      'tr>td', text: review_assignment2.team_membership.user.name, count: 1
    )
  end
end
