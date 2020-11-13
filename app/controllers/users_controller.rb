class UsersController < ApplicationController

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username:params[:user][:username])

    if user.nil?
      #new user
      user = User.new(username:params[:user][:username])
      if user.save
        flash[:welcome] = "Welcome #{user.username}"
      end
      #else what if the user doesnt save?
    else
      flash[:welcome] = "Welcome back #{user.username}"
    end
    session[:user_id] = user.id
    redirect_to root_path
    end
end
