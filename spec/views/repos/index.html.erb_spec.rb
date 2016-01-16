require 'rails_helper'

RSpec.describe "repos/index", type: :view do
  before(:each) do
    assign(:repos, [
      Repo.create!(
        :company => "Company",
        :organization => "Organization",
        :name => "Name",
        :description => "Description",
        :url => "Url"
      ),
      Repo.create!(
        :company => "Company",
        :organization => "Organization",
        :name => "Name",
        :description => "Description",
        :url => "Url"
      )
    ])
  end

  it "renders a list of repos" do
    render
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "Organization".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
