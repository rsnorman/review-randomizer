require 'rails_helper'

RSpec.describe 'teams/show', type: :view do
  before(:each) do
    @team = assign(:team, FactoryGirl.build(:team, id: 1))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Leader/)
  end
end
