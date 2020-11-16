class ApplicationController < ActionController::Base
  def require_login
    if session[:user_id].nil?
      flash[:error] = "You must be logged in first."
      redirect_to login_path
    end
  end
end
