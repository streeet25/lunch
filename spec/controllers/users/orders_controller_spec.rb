require 'spec_helper'

describe Users::OrdersController do

  login_user

  before do
    @date1 = DateTime.now
    @date2 = DateTime.now + 1.day
  end



  describe "GET #index" do
    before do
      @weekday = FactoryGirl.create(:weekday)
      @weekday2 = FactoryGirl.create(:weekday, created_at: @date2)

      @order1 = FactoryGirl.build(:order, user: @user, created_at: @date1).save(validate: false)
      @order2 = FactoryGirl.build(:order, user: @user, created_at: @date2).save(validate: false)
    end


    context 'when user is logged in' do
      context 'as user' do
        context 'without params' do
          it "renders the index template" do
            get :index, format: :html
            expect(response).to render_template("index")
          end

          it "should assert date for today" do
            expect assigns(:date) == DateTime.now
          end

          it "should assert day menu for today" do
            expect assigns(:weekday) == @weekday
          end

          it "should assert orders for today date" do
            expect assigns(:orders) == Order.where(created_at: @date1.beginning_of_day..@date1.end_of_day)
          end
        end

        context 'with date params' do
          it "renders the index template" do
            get :index, date: @date2.strftime("%d-%m-%Y"), format: :html
            expect(response).to render_template("index")
          end

          it "should assert date for date in params" do
            expect assigns(:date) == @date2.end_of_day
          end

          it "should assert day menu for date in params" do
            expect assigns(:weekday2) == @weekday2
          end

          it "should assert orders for date in params" do
            expect assigns(:orders) == Order.where(created_at: @date1.beginning_of_day..@date2.end_of_day)
          end
        end
      end
    end
  end

  describe "Get #new" do

    before do
      @weekday = FactoryGirl.create(:weekday)
    end

    it "is should return http status succes" do
      @orders = double(:build => "example")
      allow(@logged_in_user).to receive(:orders) { @orders }
      get 'new'
      expect(response).to have_http_status(:ok)
    end

    it "assigns new order to @orders" do
      @orders = double(:build => "example")
      allow(@logged_in_user).to receive(:orders) { @orders }
      get 'new'
      expect(assigns(:order)).to eq("example")
    end
  end

  describe "GET #new" do

      before do
        @weekday = FactoryGirl.create(:weekday)
      end

      it "renders the new template" do
        get :new, format: :html
        expect(response).to render_template("new")
      end

      it "should assert date for today" do
        expect assigns(:date) == DateTime.now
      end

      it "should assert day menu for today" do
        expect assigns(:weekday) == @weekday
      end


      it "should assert order" do
        expect assigns(:order) == Order.new
      end
  end
end
