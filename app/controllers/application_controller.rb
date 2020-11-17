class ApplicationController < ActionController::Base

  # Only accessible to controllers
  private

  def find_user_logged_in
    @current_user = User.find_by(id: session[:user_id])
  end

end
