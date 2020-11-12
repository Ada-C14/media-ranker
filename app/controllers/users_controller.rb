class UsersController < ApplicationController
  # Helper Methods
  def successful_login(type, user)
    flash[:notice] =
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

  def create
    @user = User.new(user_params)

    if @user.save
      # redirect_to user_path(@user.id)
      return
    else
      not_saved_error_notice
      render :new
      return
    end
  end

  # custom actions
  def login_form
    @user = User.new
  end

  def login
    username = user_params[:username]
    user = User.find_by(username: username)

    if user
      session[:user_id] = user.id
      successful_login('existing', user)
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      successful_login('new', user)
    end

    redirect_to root_path
    return
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

end
