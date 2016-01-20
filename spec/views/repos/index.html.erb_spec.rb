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
        :company => "Norman Dev",
        :organization => "All Things Serve The Code",
        :name => "Review Randomizer",
        :description => "Randomizes reviews",
        :url => "http://www.review-randomizer.com"
      )
    ])
  end

  it "renders a list of repos" do
    render
    assert_select "tr>td", :text => "Company".to_s, :count => 1
    assert_select "tr>td", :text => "Organization".to_s, :count => 1
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => "Description".to_s, :count => 1
    assert_select "tr>td", :text => "Url".to_s, :count => 1
    assert_select "tr>td", :text => "Norman Dev".to_s, :count => 1
    assert_select "tr>td", :text => "All Things Serve The Code".to_s, :count => 1
    assert_select "tr>td", :text => "Review Randomizer".to_s, :count => 1
    assert_select "tr>td", :text => "Randomizes reviews".to_s, :count => 1
    assert_select "tr>td", :text => "http://www.review-randomizer.com".to_s, :count => 1
  end
end
