class Api::V1::OrdersController < Api::V1::BaseController
  def index
    orders = User.joins(:orders).where('orders.created_at >= ?', Time.zone.now.beginning_of_day)

    respond_with_success orders
  end
end
User.joins(:posts).where('posts.created_at < ?', Time.now)
