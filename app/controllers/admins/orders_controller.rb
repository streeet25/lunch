class Admins::OrdersController < Admins::BaseController
  before_action :find_order , only: [:show, :destroy]

  def index
    @search = Order.includes(:user).ransack(params[:q])
    @orders = @search.result(distinct: false)
  end

  def show
  end

  def destroy
    @order.destroy
    redirect_to admins_orders_path
    flash[:success] = 'Order was successfully destroyed.'
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

end
