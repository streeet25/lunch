class Users::ProfileController < Users::BaseController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
      sign_in(current_user, bypass: true)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, profile_attributes: [:last_name])
  end
end
