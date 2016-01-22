require 'rails_helper'

RSpec.describe 'repos/show', type: :view do
  before(:each) do
    @repo = assign(:repo, FactoryGirl.build(:repo, id: 1))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Company/)
    expect(rendered).to match(/Organization/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Owner/)
  end
end
