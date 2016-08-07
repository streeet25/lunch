class Api::V1::BaseController < ActionController::Base
  respond_to :json

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :respond_with_internal_error

    rescue_from CanCan::AccessDenied, NotAuthorized, with: :not_autorized

    rescue_from ActiveRecord::RecordNotFound,
                ActionController::RoutingError,
                ActiveRecord::RecordInvalid,
                with: :respond_with_not_found
  end

  def respond_with_success(data,status=200)
    render json: data, status: status, root: false
  end

  def respond_with_error(data,status=422)
    render json: {success: false, errors: object.errors, errors_messages: object.errors.full_massages}, status: status
  end

  def respond_with_not_found
    render json: {success: false, messages: 'Cant found record'}, status: 404
  end

  def respond_with_internal_error(exception)
    response = {success: false, message: 'Internal error'}
    response.merge!(debug:exception.message) unless Rails.env.production?
    render json: response, status: 500
  end
end
