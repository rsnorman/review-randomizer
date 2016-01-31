require 'rails_helper'

RSpec.describe 'api/v1/pull_requests/create', type: :view do
  let(:repo) { FactoryGirl.create(:repo) }
  let(:pull_request) { FactoryGirl.create(:pull_request, repo: repo) }
  let(:review_assignment1) { FactoryGirl.create(:review_assignment) }
  let(:review_assignment2) { FactoryGirl.create(:review_assignment) }

  before do
    pull_request.review_assignments << review_assignment1
    pull_request.review_assignments << review_assignment2
  end

  before(:each) do
    assign(:pull_request, pull_request)
  end

  it 'renders pull request JSON' do
    render
    rendered_json = JSON.parse(rendered)['pull_request']
    expect(rendered_json['id']).to eq pull_request.id
    expect(rendered_json['title']).to eq pull_request.title
    expect(rendered_json['number']).to eq pull_request.number
    expect(rendered_json['created_at']).to eq pull_request.created_at.iso8601
    expect(rendered_json['updated_at']).to eq pull_request.updated_at.iso8601
  end

  it 'renders review assignment JSON' do
    render
    rendered_json = JSON.parse(rendered)['pull_request']
    expect(rendered_json['review_assignments'].first)
      .to eq review_assignment1.assignee_handle
    expect(rendered_json['review_assignments'].second)
      .to eq review_assignment2.assignee_handle
  end

  it 'renders pull request actions' do
    render
    rendered_json = JSON.parse(rendered)['pull_request']
    expect(rendered_json['actions']['show']).to eq(
      "http://test.host:80/repos/#{repo.id}/pull_requests/#{pull_request.id}"
    )
  end
end
