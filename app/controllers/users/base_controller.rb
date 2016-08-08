class Users::BaseController < ApplicationController
  before_filter :authenticate_user!

  authorize_resource
end
