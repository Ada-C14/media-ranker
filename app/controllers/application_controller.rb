class ApplicationController < ActionController::Base
  before_action :current_user

  add_flash_types :warning, :success

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
