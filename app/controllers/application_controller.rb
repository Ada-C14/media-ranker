class ApplicationController < ActionController::Base
  def authentication_notice
    flash[:notice] = 'Please log in to perform this action'
  end

  def self.check_login
    @user = User.find_by(id: session[:user_id])

    unless @user
      authentication_notice
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
