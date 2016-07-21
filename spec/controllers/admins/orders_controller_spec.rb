require 'spec_helper'

describe Admins::OrdersController do

  login_admin

  before do
    @order = FactoryGirl.create(:order)
  end



  describe "get #index"

    context "when user logged in" do
        before do
          @orders = double
          allow(@logged_in_admin).to receive(:orders) { @orders }
          get :index
        end

        it "is should return http status succes" do
          expect(response).to have_http_status(:ok)
        end

        it "renders 'index template'" do
          expect(response).to render_template('index')
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

    describe " #show" do

      it 'it should find @order' do
      get :show, id: @order.to_param
      expect(assigns(:order)) == eq(@order)
    end
  end

  describe "delete 'destroy'" do
    before do
      @orders = double
      allow(@logged_in_user).to receive(:orders) { @orders }
      allow(@orders).to receive(:find) { order }
      allow(@order).to receive(:destroy) { true }
    end

    it 'should assigns rating to instance variable' do
      do_request
      expect(assigns(:order)).to eq(@order)
    end


    it 'add message to notice' do
        do_request
        expect(flash[:success]).to eq('Order was successfully destroyed.')
      end

    it 'redirects to the orders list' do
      do_request
      expect(response).to redirect_to(admins_orders_path)
    end

    def do_request
      delete :destroy, id: @order.id
    end
  end
end
