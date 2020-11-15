class ApplicationController < ActionController::Base
  def find_current_user
    @user = session[:user_id].nil? ? nil : User.find_by_id(session[:user_id])
  end
end
