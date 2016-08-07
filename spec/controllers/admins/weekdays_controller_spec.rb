require 'spec_helper'

describe Admins::WeekdaysController do


  login_admin

  let!(:weekday) { FactoryGirl.create :weekday }

  let(:products) { [weekday.products[0].id, weekday.products[1].id, weekday.products[2].id] }

  describe "Get #index" do
    context "when user logged in" do
      before do
        @weekdays = double
        allow(@weekdays).to receive(:name).with("weekdays").and_return("weekdays")
        allow(@logged_in_user).to receive(:weekdays) { @weekdays }
        get :index
      end

      it "is should return http status succes" do
        expect(response).to have_http_status(:ok)
      end

      it "renders 'index template'" do
        expect(response).to render_template('index')
      end

      it "assign user as users" do
        expect(@weekdays.name("weekdays")).to eq("weekdays")
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
      @weekdays = double(:build => "example")
      allow(@logged_in_user).to receive(:weekdays) { @weekdays }
      get :new
      expect(response).to have_http_status(:ok)
    end

    it "creates a new item" do
      get :new
      expect(assigns(:weekday)).to be_a_new(Weekday)
    end
  end

  describe "POST 'create'" do

     let(:weekday_double) { double("weekday_double")}
    context "when product was created" do
      before(:each) do
        Weekday.stub(:new).and_return(weekday_double)
        weekday_double.stub(:save).and_return(true)
      end

      it "creates a new weekday" do
        do_request_weekday
        expect(assigns(:weekday)).to be(weekday_double)
      end

      it "redirects to the correct url" do
        do_request_weekday
        expect(response).to redirect_to admins_weekdays_path
      end

      it 'add message to notice' do
        do_request_weekday
        expect(flash[:success]).to eq("Weekday created.")
      end
    end

    context "when product wasn't created" do

      before(:each) do
        Weekday.stub(:new).and_return(weekday_double)
        weekday_double.stub(:save).and_return(false)
      end

      it 'should render new' do
        do_request_weekday
        get :new
        expect(response).to render_template('new')
      end

      it 'add message to notice' do
        do_request_weekday
        expect(flash[:error]).to eq('Something goes wrong.')
      end
    end

    def do_request_weekday
      post 'create', { :weekday =>  { :name => 'example'  }}
    end
  end

  describe "post 'edit'" do

    @weekday= Weekday.create

    it "finds a specific item" do
      get :edit, id: weekday.id
      expect(assigns(:weekday)).to eq(weekday)

    end

    it "is should return http status succes" do
      get :edit, id: weekday.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe "put 'update'"  do

    before do
      @weekdays = double
      allow(@logged_in_user).to receive(:weekdays) { @weekdays }
      allow(@weekdays).to receive(:find) { weekday }
    end

    it 'should assigns weekdays to instance variable' do
      do_request
      expect(assigns(:weekday)).to eq(weekday)
    end

    context "when product was updated" do
      before do
        allow(weekday).to receive(:update_attributes) { true }
      end

      it 'should redirect to admins_weekdays_path' do
        do_request
        expect(response).to redirect_to(admins_weekdays_path)
      end

      it 'add message to notice' do
        do_request
        expect(flash[:success]).to eq('Weekday was successfully updated.')
      end
    end

    context "when weekday wasn't updated" do
      before do
        allow(weekday).to receive(:update_attributes) { false }
      end

      it 'should render new' do
        do_request
        get :edit, id: weekday.id
        expect(response).to render_template(:edit)
      end
    end

    def do_request
      put 'update', { :id => weekday.id,  :weekday => { :name => 'example'  }}
    end
  end

  describe "delete 'destroy'" do

    before do
      @weekdays = double
      allow(@logged_in_user).to receive(:weekdays) { @weekdays }
      allow(@weekdays).to receive(:find) { weekday }
    end

    it 'should assigns weekday to instance variable' do
      do_request
      expect(assigns(:weekday)).to eq(weekday)
    end

    context "when weekday was destroyed" do
      before do
        allow(weekday).to receive(:destroy) { true }
      end

      it 'add message to notice' do
        do_request
        expect(flash[:success]).to eq('Weekday was successfully destroyed.')
      end
    end


    it 'should redirect to admins_weekdays_path' do
      do_request
      expect(response).to redirect_to(admins_weekdays_path)
    end

    def do_request
      delete 'destroy', { :id => weekday.id }
    end
  end


end
