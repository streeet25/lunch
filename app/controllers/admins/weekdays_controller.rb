class Admins::WeekdaysController < Admins::BaseController
  before_action :find_weekday, only: [:edit, :update, :destroy, :show]

  def index
    @weekdays = Weekday.order(:id)
  end

  def new
    @weekday = Weekday.new
  end

  def create
    @weekday = Weekday.new(weekday_params)
    if @weekday.save
      flash[:success] = 'Weekday created.'
      redirect_to admins_weekdays_path
    else
      flash[:error] = 'Something goes wrong.'
      render :new
    end
  end

  def edit
  end

  def update
    if @weekday.update(weekday_params)
      redirect_to admins_weekdays_path
      flash[:success] = 'Weekday was successfully updated.'
    else
      render :edit
      flash[:error] = 'Something goes wrong.'
    end
  end

  def destroy
    @weekday.destroy
    redirect_to admins_weekdays_path
    flash[:success] = 'Weekday was successfully destroyed.'
  end

  def show
  end

  private

  def find_weekday
    @weekday = Weekday.find(params[:id])
  end

  def weekday_params
    params.require(:weekday).permit(:name, :date, product_ids: [])
  end
end
