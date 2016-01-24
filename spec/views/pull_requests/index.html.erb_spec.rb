require 'rails_helper'

RSpec.describe "pull_requests/index", type: :view do
  before(:each) do
    assign(:pull_requests, [
      PullRequest.create!(
        :repo => nil,
        :title => "Title",
        :number => 1
      ),
      PullRequest.create!(
        :repo => nil,
        :title => "Title",
        :number => 1
      )
    ])
  end

  it "renders a list of pull_requests" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
