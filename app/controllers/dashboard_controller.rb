class DashboardController < ApplicationController
  def index
    @weekdays = Weekday.order(:date)
  end

  def show
  end
end
