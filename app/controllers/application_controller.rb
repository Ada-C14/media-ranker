class ApplicationController < ActionController::Base

  # returns the current user, or the user matching the user_id of the current session
  def current_user
    if session[:user_id]
      return User.find_by(id: session[:user_id])
    end
  end



end
