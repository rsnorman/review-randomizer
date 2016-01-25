require 'rails_helper'

RSpec.describe 'pull_requests/index', type: :view do
  let(:repo) { FactoryGirl.create(:repo) }
  let(:pr1)  { FactoryGirl.create(:pull_request, repo: repo) }
  let(:pr2)  { FactoryGirl.create(:pull_request, repo: repo) }

  before(:each) do
    assign(:repo, repo)
    assign(:pull_requests, [pr1, pr2])
  end

  it 'renders a list of pull_requests' do
    render
    assert_select 'tr>td', text: repo.name, count: 2
    assert_select 'tr>td', text: pr1.title, count: 1
    assert_select 'tr>td', text: "##{pr1.number}", count: 1
    assert_select 'tr>td', text: pr2.title, count: 1
    assert_select 'tr>td', text: "##{pr2.number}", count: 1
  end
end
