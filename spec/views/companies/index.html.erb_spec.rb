require 'rails_helper'

RSpec.describe "companies/index", type: :view do
  let(:company1) { FactoryGirl.create(:company) }
  let(:company2) { FactoryGirl.create(:company) }

  before(:each) do
    assign(:companies, [company1, company2])
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", :text => company1.name, :count => 1
    assert_select "tr>td", :text => company1.token, :count => 1
    assert_select "tr>td", :text => company1.domain, :count => 1
    assert_select "tr>td", :text => company1.owner.name, :count => 1
    assert_select "tr>td", :text => company2.name, :count => 1
    assert_select "tr>td", :text => company2.token, :count => 1
    assert_select "tr>td", :text => company2.domain, :count => 1
    assert_select "tr>td", :text => company2.owner.name, :count => 1
  end
end
