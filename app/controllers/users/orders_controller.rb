class Users::OrdersController < Users::BaseController
  def index
    @weekday = params[:weekday].to_date.strftime('%A') if params[:weekday]
    @daymenu = Weekday.find_by_date(params[:weekday])
    @date = params[:weekday]
  end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build
    @order.products << Product.where(id: params[:product_ids])

    if @order.save
      redirect_to users_order_path(@order)
      flash[:success] = 'Your order successfully sent'
    else
      flash[:error] = 'Something goes wrong.'
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
