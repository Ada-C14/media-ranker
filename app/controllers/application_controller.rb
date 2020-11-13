class ApplicationController < ActionController::Base
  # before_action :require_login

  def current_user
    # return user matching id from session variable
    return User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    if current_user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: root_path)
    end
  end
end
