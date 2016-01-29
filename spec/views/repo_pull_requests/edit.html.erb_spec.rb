require 'rails_helper'

RSpec.describe 'repo_pull_requests/edit', type: :view do
  let(:repo) { FactoryGirl.create(:repo) }
  let(:pull_request) { FactoryGirl.create(:pull_request, repo: repo) }

  before(:each) do
    assign(:repo, repo)
    assign(:pull_request, pull_request)
  end

  it 'renders the edit pull_request form' do
    render

    assert_select(
      'form[action=?][method=?]',
      repo_pull_request_path(repo, pull_request),
      'post') do
      assert_select(
        'select#pull_request_repo_id[name=?]', 'pull_request[repo_id]'
      )

      assert_select 'input#pull_request_title[name=?]', 'pull_request[title]'

      assert_select 'input#pull_request_number[name=?]', 'pull_request[number]'
    end
  end
end
