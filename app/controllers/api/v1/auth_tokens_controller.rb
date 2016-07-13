class Api::V1::AuthTokensController < ActionController::Base
  def create
    if params[:email].present? && params[:password].present?
      auth_token = authenticate_by_email
    elsif params[:service_name].present?
      auth_token = authenticate_through_social_network
    end

    raise NotAuthorized unless auth_token.present?
    render json: { success: true, auth_token: auth_token }, status: 201
  end

  private

  def authenticate_by_email
    user = User.find_by_email(params[:email])
    user.authentication_token if user.present? && user.valid_password?(params[:password])
  end

  def authenticate_through_social_network
    return if params[:access_token].empty?
    profile = google.get_object('me')

    social_profile = SocialProfile.find_by(uid: profile['id'], service_name: 'google')
    authentication_token_by_social_profile(social_profile)
  end

  def authentication_token_by_social_profile(social_profile)
    if social_profile.present?
      user = social_profile.user
      user.authentication_token if user.present?
    end
  end

  def google
    @google = Signet::OAuth2::Client.new do |config|
        config.consumer_key        = ENV['google_token']
        config.consumer_secret     = ENV['google_key']
        config.access_token        = params[:access_token]
        config.access_token_secret = params[:secret_key]
      end
  end
end
