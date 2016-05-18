class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :redirect_with_error

    rescue_from CanCan::AccessDenied, with: :not_autorized

    rescue_from ActiveRecord::RecordNotFound,
                ActionController::RoutingError,
                ActiveRecord::RecordInvalid,
                with: :redirect_with_error
  end

  private

  def redirect_with_error
    flash[:error] = 'Something goes wrong'
    redirect_to root_path
  end

  def not_autorized
    flash[:error] = 'You not authorized to perform this action'
    redirect_to root_path
  end
end
