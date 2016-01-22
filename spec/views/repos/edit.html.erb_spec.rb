require 'rails_helper'

RSpec.describe "repos/edit", type: :view do
  before(:each) do
    @repo = assign(:repo, FactoryGirl.create(:repo))
  end

  it "renders the edit repo form" do
    render

    assert_select "form[action=?][method=?]", repo_path(@repo), "post" do

      assert_select "input#repo_company[name=?]", "repo[company]"

      assert_select "input#repo_organization[name=?]", "repo[organization]"

      assert_select "input#repo_name[name=?]", "repo[name]"

      assert_select "textarea#repo_description[name=?]", "repo[description]"

      assert_select "input#repo_url[name=?]", "repo[url]"
    end
  end
end
