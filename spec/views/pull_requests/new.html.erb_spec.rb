require 'rails_helper'

RSpec.describe 'pull_requests/new', type: :view do
  let(:repo) { FactoryGirl.create(:repo) }
  let(:pull_request) do
    PullRequests::UrlPullRequest.new(repo.pull_requests.build)
  end

  before(:each) do
    assign(:pull_request, pull_request)
  end

  it 'renders new pull_request form' do
    render

    assert_select('form[action=?][method=?]', pull_requests_path, 'post') do
      assert_select 'input#pull_request_title[name=?]', 'pull_request[title]'
      assert_select 'input#pull_request_url[name=?]', 'pull_request[url]'
    end
  end
end
