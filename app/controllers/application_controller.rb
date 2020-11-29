class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
      @current_user = User.find_by(id: session[:user_id])
      # unless @current_user
      #   flash[:error] = "You must be logged in to see this page"
      #   redirect_to root_path
      #   return
      # end
      # return @current_user
  end

  def require_login
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end

end
