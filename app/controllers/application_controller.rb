class ApplicationController < ActionController::Base
  def authentication_notice
    flash[:notice] = 'Please log in to perform this action'
  end

  def not_saved_error_notice(action)
    flash.now[:notice] =
      if @work
        "A problem occurred: Could not #{action} #{@work.category}"
      else
        "A problem occurred: Could not #{action} user. Please try again."
      end
  end

  def verify_login
    @user = User.find_by(id: session[:user_id])

    unless @user
      authentication_notice
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
