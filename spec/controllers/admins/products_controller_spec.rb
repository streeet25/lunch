require 'spec_helper'

describe Admins::ProductsController do

  login_admin

  let!(:product) { FactoryGirl.create :product }

  describe "Get #index" do

    context "when user logged in" do
      before do
        @products = double
        allow(@logged_in_user).to receive(:product) { @products }
        get :index
      end

      it "is should return http status succes" do
        expect(response).to have_http_status(:ok)
      end

      it "renders 'index template'" do
        expect(response).to render_template('index')
      end

      it "assign ratings as ratings" do
        expect(assigns(@products)).to eq(@products1)
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

  describe "Get #new" do
    it "is should return http status succes" do
      @products1 = double(:build => "example")
      allow(@logged_in_user).to receive(:products) { @products }
      get 'new'
      expect(response).to have_http_status(:ok)
    end

    before(:each) do
      get :new
    end

    it "creates a new item" do
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "POST 'create'" do
    context "when product was created" do
      before do
        @product = double(:save => true)
        @products = double(:build => @products)
      end

      it 'should redirect ' do
        do_request_product
        expect(response).to redirect_to(admins_products_path)
      end

      it 'add message to notice' do
        do_request_product
        expect(flash[:success]).to eq('Product was successfully created.')
      end
    end

    context "when rating wasn't created" do

      before do
        allow(@logged_in_user).to receive(:products) { @products }
        @product = double(:save => false)
        @products = double(:build => @product)
      end

      it 'should render new' do
        do_request_product
        get :new
        expect(response).to render_template('new')
      end

      it 'add message to notice' do
        do_request_product
        expect(flash[:error]).to eq('Something goes wrong.')
      end
    end

    def do_request_product
      post 'create', { :product =>  { :name => 'example'  }}
    end
  end




end
