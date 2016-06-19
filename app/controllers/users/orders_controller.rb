class Users::OrdersController < Users::BaseController
  def index
    @order= current_user.orders
  end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.items << Item.where(id: params[:product_ids])

    if @order.save
      redirect_to root_path
      flash[:success] = 'Your order successfully sent'
    else
      render :new
      flash[:error] = 'Something goes wrong.'
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :total)
  end

end
