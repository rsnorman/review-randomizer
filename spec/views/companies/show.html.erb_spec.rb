require 'rails_helper'

RSpec.describe "companies/show", type: :view do
  let(:company) { FactoryGirl.create(:company) }
  before(:each) do
    @company = assign(:company, company)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(Regexp.new(company.token))
    expect(rendered).to match(Regexp.new(company.domain))
    expect(rendered).to match(Regexp.new(company.owner.name))
  end
end
