class Users::OrdersController < Users::BaseController
  def index
    @order= current_user.orders
  end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_item_params)
    @order.items << Item.where(id: params[:product_ids])

    if @order.save
      redirect_to root_path
      flash[:success] = 'Your order successfully sent'
    else
      render :new
      flash[:error] = 'Something goes wrong.'
    end

  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id)
  end

end
