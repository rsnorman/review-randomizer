require 'rails_helper'

RSpec.describe 'pull_requests/show', type: :view do
  let(:repo) { FactoryGirl.create(:repo) }
  let(:pull_request) { FactoryGirl.create(:pull_request, repo: repo) }

  before(:each) do
    assign(:repo, repo)
    assign(:pull_request, pull_request)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(Regexp.new(repo.name))
    expect(rendered).to match(Regexp.new(CGI.escape_html(pull_request.title)))
    expect(rendered).to match(Regexp.new("##{pull_request.number}"))
  end
end
