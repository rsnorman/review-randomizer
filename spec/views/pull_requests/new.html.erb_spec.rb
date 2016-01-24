require 'rails_helper'

RSpec.describe "pull_requests/new", type: :view do
  before(:each) do
    assign(:pull_request, PullRequest.new(
      :repo => nil,
      :title => "MyString",
      :number => 1
    ))
  end

  it "renders new pull_request form" do
    render

    assert_select "form[action=?][method=?]", pull_requests_path, "post" do

      assert_select "input#pull_request_repo_id[name=?]", "pull_request[repo_id]"

      assert_select "input#pull_request_title[name=?]", "pull_request[title]"

      assert_select "input#pull_request_number[name=?]", "pull_request[number]"
    end
  end
end
