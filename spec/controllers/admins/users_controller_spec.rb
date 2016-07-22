require 'spec_helper'

describe Admins::UsersController do

  login_admin

  let!(:user) { FactoryGirl.create :user }

  describe "Get #index" do
    context "when user logged in" do
      before do
        @users = double(:build => "example")
        allow(@logged_in_user).to receive(:user) { @users }
        get :index
      end

      it "is should return http status succes" do
        expect(response).to have_http_status(:ok)
      end

      it "renders 'index template'" do
        expect(response).to render_template('index')
      end

      it "assign product as products" do
        expect(assigns(@user)).to eq(@users1)
      end
    end

    context "when user is logged out" do
      before do
        get :index
      end
      it "redirect to sign_in path" do
        expect {should redirect_to new_user_session}
      end
      it "render warning" do
        expect { should set_the_flash(:warning).to('You need to sign in or sign up before continuing.') }
      end
    end
  end


end
