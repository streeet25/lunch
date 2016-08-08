require 'spec_helper'

describe Admins::UsersController do
  login_admin

  before do
  end

  let!(:user) { create(:user) }

  describe 'Get #index' do
    context 'when user logged in' do
      before do
        @users = double
        allow(@users).to receive(:first_name).with('jjj').and_return('jjj')
        allow(@logged_in_user).to receive(:users) { @users }
        get :index
      end

      it 'is should return http status succes' do
        expect(response).to have_http_status(:ok)
      end

      it "renders 'index template'" do
        expect(response).to render_template('index')
      end

      it 'assign user as users' do
        expect(@users.first_name('jjj')).to eq('jjj')
      end
    end

    context 'when user is logged out' do
      before do
        get :index
      end
      it 'redirect to sign_in path' do
        expect { should redirect_to new_user_session }
      end
      it 'render warning' do
        expect { should set_the_flash(:warning).to('You need to sign in or sign up before continuing.') }
      end
    end
  end

  describe "post 'edit'" do
    @user = User.create

    it 'finds a specific item' do
      get :edit, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it 'is should return http status succes' do
      get :edit, id: user.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe "put 'update'" do
    before do
      @users = double
      allow(@logged_in_user).to receive(:users) { @users }
      allow(@users).to receive(:find) { user }
    end

    it 'should assigns user to instance variable' do
      do_request
      expect(assigns(:user)).to eq(user)
    end

    context 'when user was updated' do
      before do
        allow(user).to receive(:update_attributes) { true }
      end

      it 'should redirect to admins_users_path' do
        do_request
        expect(response).to redirect_to(admins_users_path)
      end

      it 'add message to notice' do
        do_request
        expect(flash[:success]).to eq('User was successfully updated.')
      end
    end

    context "when user wasn't updated" do
      before do
        allow(user).to receive(:update_attributes) { false }
      end

      it 'should render new' do
        do_request
        get :edit, id: user.id
        expect(response).to render_template(:edit)
      end
    end

    def do_request
      put 'update', id: user.id, user: { first_name: 'example' }
    end
  end

  describe "delete 'destroy'" do
    before do
      @users = double
      allow(@logged_in_user).to receive(:users) { @users }
      allow(@users).to receive(:find) { user }
    end

    it 'should assigns product to instance variable' do
      do_request
      expect(assigns(:user)).to eq(user)
    end

    context 'when product was destroyed' do
      before do
        allow(user).to receive(:destroy) { true }
      end

      it 'add message to notice' do
        do_request
        expect(flash[:success]).to eq('User was successfully destroyed.')
      end
    end

    it 'should redirect to admins_users_path' do
      do_request
      expect(response).to redirect_to(admins_users_path)
    end

    def do_request
      delete 'destroy', id: user.id
    end
  end
end
