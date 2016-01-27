require 'rails_helper'

RSpec.describe 'repos/show', type: :view do
  before(:each) do
    @repo = assign(:repo, FactoryGirl.build(:repo, id: 1))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(Regexp.new(CGI.escape_html(@repo.organization)))
    expect(rendered).to match(Regexp.new(CGI.escape_html(@repo.name)))
    expect(rendered).to match(Regexp.new(CGI.escape_html(@repo.description)))
    expect(rendered).to match(Regexp.new(@repo.url))
    expect(rendered).to match(Regexp.new(CGI.escape_html(@repo.owner.name)))
    expect(rendered).to match(/Pull Requests/)
  end
end
