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

  #########################################################

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
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
end
