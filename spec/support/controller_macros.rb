module ControllerMacros
  def login_admin
    before(:each) do
      User.delete_all
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @logged_in_admin = FactoryGirl.create(:admin)
      sign_in @logged_in_admin
      allow(controller).to receive(:current_user).and_return(@logged_in_admin)
    end
  end

  def login_user
    before(:each) do
      User.delete_all
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @logged_in_user = FactoryGirl.create(:user)
      sign_in @logged_in_user
      allow(controller).to receive(:current_user).and_return(@logged_in_user)
    end
  end
end
