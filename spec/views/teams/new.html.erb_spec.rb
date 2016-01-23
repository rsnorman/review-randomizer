require 'rails_helper'

RSpec.describe 'teams/new', type: :view do
  before(:each) do
    assign(:team, Team.new(
                    name: 'MyString'
    ))
  end

  it 'renders new team form' do
    render

    assert_select 'form[action=?][method=?]', teams_path, 'post' do
      assert_select 'input#team_name[name=?]', 'team[name]'
      assert_select 'select#team_repo_ids[name=?]', 'team[repo_ids][]'
    end
  end
end
