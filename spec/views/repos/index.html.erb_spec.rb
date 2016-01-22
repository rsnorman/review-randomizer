require 'rails_helper'

RSpec.describe 'repos/index', type: :view do
  let(:repo1) { FactoryGirl.build(:repo, id: 1) }
  let(:repo2) { FactoryGirl.build(:repo, id: 2) }

  before(:each) do
    assign(:repos, [repo1, repo2])
  end

  it 'renders a list of repos' do
    render
    assert_select 'tr>td', text: repo1.company, count: 1
    assert_select 'tr>td', text: repo1.organization, count: 1
    assert_select 'tr>td', text: repo1.name, count: 1
    assert_select 'tr>td', text: repo1.description, count: 1
    assert_select 'tr>td', text: repo1.url, count: 1
    assert_select 'tr>td', text: repo1.owner.name, count: 1
    assert_select 'tr>td', text: repo2.company, count: 1
    assert_select 'tr>td', text: repo2.organization, count: 1
    assert_select 'tr>td', text: repo2.name, count: 1
    assert_select 'tr>td', text: repo2.description, count: 1
    assert_select 'tr>td', text: repo2.url, count: 1
    assert_select 'tr>td', text: repo2.owner.name, count: 1
  end
end
