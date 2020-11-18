class ApplicationController < ActionController::Base

  # returns the current user, or the user matching the user_id of the current session
  def current_user
    if session[:user_id]
      return User.find_by(id: session[:user_id])
    end
  end

  # requires that user is logged in for an action to run
  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to vote"
      redirect_to login_path
    end
  end


end
