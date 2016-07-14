class Admins::UsersController < Admins::BaseController
  before_action :find_user , only: [:edit, :update, :destroy]

  PER_PAGE = 10

  def index
    @users = User.all.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_users_path
      flash[:success] = 'User was successfully updated.'
    else
      flash[:error] = 'Something goes wrong.'
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admins_users_path
    flash[:success] = 'User was successfully destroyed.'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, profile_attributes: [:last_name])
  end
end
