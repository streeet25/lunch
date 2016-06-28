class DashboardController < ApplicationController

  def index
    @date = Date.today.at_beginning_of_week
  end

  def show
  end
end
