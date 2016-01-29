require 'rails_helper'

RSpec.describe 'repo_pull_requests/new', type: :view do
  let(:repo) { FactoryGirl.create(:repo) }
  let(:pull_request) { repo.pull_requests.build }

  before(:each) do
    assign(:repo, repo)
    assign(:pull_request, pull_request)
  end

  it 'renders new pull_request form' do
    render

    assert_select(
      'form[action=?][method=?]',
      repo_pull_requests_path(repo),
      'post') do
      assert_select(
        'select#pull_request_repo_id[name=?]', 'pull_request[repo_id]'
      )

      assert_select 'input#pull_request_title[name=?]', 'pull_request[title]'

      assert_select 'input#pull_request_number[name=?]', 'pull_request[number]'
    end
  end
end
