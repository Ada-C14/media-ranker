class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user # existing user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{username}"
    else # new user "Successfully created new user testingcat with ID 874"
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{username} with ID #{user.id}"
    end

    redirect_to root_path
    return
  end
end
