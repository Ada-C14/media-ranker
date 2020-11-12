class UsersController < ApplicationController
  # Helper Methods
  def successful_login(type, user)
    flash[:success] =
      if type == 'new'
        "Successfully created new user #{user.username} with ID #{user.id}"
      else
        "Successfully logged in as existing user #{user.username}"
      end
  end

  def not_saved_error_notice
    flash.now[:notice] = "Uh oh! That did not save correctly. Please try again."
  end

  #########################################################

  # Custom actions
  def login_form
    @user = User.new
  end

  def login
    username = user_params[:username]
    user = User.find_by(username: username)

    if user
      successful_login('existing', user)
    else
      user = User.new(user_params)
      if user.save
        successful_login('new', user)
      else
        not_saved_error_notice
        render :login_form
        return
      end
    end

    session[:user_id] = user.id
    redirect_to root_path
    return
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

end
