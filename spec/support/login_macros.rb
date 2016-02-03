module LoginMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @admin_user = FactoryGirl.create(:admin)
      @admin_user.confirm
      sign_in @admin_user
    end
  end

  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end
  end
end
