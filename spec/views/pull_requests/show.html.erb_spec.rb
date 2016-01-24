require 'rails_helper'

RSpec.describe "pull_requests/show", type: :view do
  before(:each) do
    @pull_request = assign(:pull_request, PullRequest.create!(
      :repo => nil,
      :title => "Title",
      :number => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
  end
end
