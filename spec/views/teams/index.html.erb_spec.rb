require 'rails_helper'

RSpec.describe 'teams/index', type: :view do
  let(:team1) { FactoryGirl.build(:team, id: 1) }
  let(:team2) { FactoryGirl.build(:team, id: 2) }
  before(:each) do
    assign(:teams, [
             team1,
             team2
           ])
  end

  it 'renders a list of teams' do
    render
    assert_select 'tr>td', text: team1.name, count: 1
    assert_select 'tr>td', text: team1.leader.name, count: 1
    assert_select 'tr>td', text: team2.name, count: 1
    assert_select 'tr>td', text: team2.leader.name, count: 1
  end
end
