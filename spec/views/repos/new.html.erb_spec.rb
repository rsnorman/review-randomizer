require 'rails_helper'

RSpec.describe 'repos/new', type: :view do
  before(:each) do
    assign(:repo, Repo.new(
                    company: 'MyString',
                    organization: 'MyString',
                    name: 'MyString',
                    description: 'MyString',
                    url: 'MyString'
    ))
  end

  it 'renders new repo form' do
    render

    assert_select 'form[action=?][method=?]', repos_path, 'post' do
      assert_select 'input#repo_company[name=?]', 'repo[company]'

      assert_select 'input#repo_organization[name=?]', 'repo[organization]'

      assert_select 'input#repo_name[name=?]', 'repo[name]'

      assert_select 'textarea#repo_description[name=?]', 'repo[description]'

      assert_select 'input#repo_url[name=?]', 'repo[url]'
    end
  end
end
