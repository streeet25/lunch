require 'spec_helper'

describe Admins::ProductsController do
  login_admin

  let!(:product) { FactoryGirl.create :product }

  describe 'Get #index' do
    context 'when user logged in' do
      before do
        @products = double
        allow(@logged_in_user).to receive(:product) { @products }
        get :index
      end

      it 'is should return http status succes' do
        expect(response).to have_http_status(:ok)
      end

      it "renders 'index template'" do
        expect(response).to render_template('index')
      end

      it 'assign product as products' do
        expect(assigns(@products)).to eq(@products1)
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

  describe 'Get #new' do
    it 'is should return http status succes' do
      @products1 = double(build: 'example')
      allow(@logged_in_user).to receive(:products) { @products }
      get :new
      expect(response).to have_http_status(:ok)
    end

    it 'creates a new item' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "POST 'create'" do
    let(:product_double) { double('product_double') }
    context 'when product was created' do
      before(:each) do
        Product.stub(:new).and_return(product_double)
        product_double.stub(:save).and_return(true)
      end

      it 'creates a new item' do
        do_request_product
        expect(assigns(:product)).to be(product_double)
      end

      it 'redirects to the correct url' do
        do_request_product
        expect(response).to redirect_to admins_products_path
      end

      it 'add message to notice' do
        do_request_product
        expect(flash[:success]).to eq('Product was successfully created.')
      end
    end

    context "when product wasn't created" do
      before(:each) do
        Product.stub(:new).and_return(product_double)
        product_double.stub(:save).and_return(false)
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
      post 'create', product: { name: 'example' }
    end
  end

  describe "post 'edit'" do
    @product = Product.create

    it 'finds a specific item' do
      get :edit, id: product.id
      expect(assigns(:product)).to eq(product)
    end

    it 'is should return http status succes' do
      get :edit, id: product.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe "put 'update'" do
    before do
      @products = double
      allow(@logged_in_user).to receive(:products) { @products }
      allow(@products).to receive(:find) { product }
    end

    it 'should assigns product to instance variable' do
      do_request
      expect(assigns(:product)).to eq(product)
    end

    context 'when product was updated' do
      before do
        allow(product).to receive(:update_attributes) { true }
      end

      it 'should redirect to admins_products_path' do
        do_request
        expect(response).to redirect_to(admins_products_path)
      end

      it 'add message to notice' do
        do_request
        expect(flash[:success]).to eq('Product was successfully updated.')
      end
    end

    context "when product wasn't updated" do
      before do
        allow(product).to receive(:update_attributes) { false }
      end

      it 'should render new' do
        do_request
        get :edit, id: product.id
        expect(response).to render_template(:edit)
      end
    end

    def do_request
      put 'update', id: product.id, product: { name: 'example' }
    end
  end

  describe "delete 'destroy'" do
    before do
      @products = double
      allow(@logged_in_user).to receive(:products) { @products }
      allow(@products).to receive(:find) { product }
    end

    it 'should assigns product to instance variable' do
      do_request
      expect(assigns(:product)).to eq(product)
    end

    context 'when product was destroyed' do
      before do
        allow(product).to receive(:destroy) { true }
      end

      it 'add message to notice' do
        do_request
        expect(flash[:success]).to eq('Product was successfully destroyed.')
      end
    end

    it 'should redirect to admins_products_path' do
      do_request
      expect(response).to redirect_to(admins_products_path)
    end

    def do_request
      delete 'destroy', id: product.id
    end
  end
end
