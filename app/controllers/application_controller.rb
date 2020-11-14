class ApplicationController < ActionController::Base
  # Shared flash notices
  def authentication_notice
    flash[:notice] = 'Please log in to perform this action'
  end

  def not_saved_error_notice(action)
    flash.now[:notice] =
      if @work
        "A problem occurred: Could not #{action} #{@work.category}"
      else
        'A problem occurred: Could not login. Please make sure that you are entering a valid username.'
      end
  end

  def not_found_error_notice
    if params[:controller] == 'works'
      flash[:notice] = 'Uh oh! That work could not be found... Please try again.'
      redirect_to works_path
    else
      flash[:notice] = 'Uh oh! That user could not be found... Please try again.'
      redirect_to users_path
    end
  end

  def verify_login
    @user = User.find_by(id: session[:user_id])
    return @user
  end
end
