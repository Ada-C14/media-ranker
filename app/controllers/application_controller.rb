class ApplicationController < ActionController::Base
  before_action :require_login

  def require_login
    # if session[:user_id] is nil, set error flash variable, redirect to login path
    if session[:user_id].nil?
      flash[:error] = "A problem occurred: Could not log in"
      redirect_to login_path
    end
  end
end
