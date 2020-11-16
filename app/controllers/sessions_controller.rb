class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(name: params[:name])
    if user
      session[:user_id] = user.id
      flash[:success] = "Existing user '#{user.name}' logged in!"
      redirect_to user_path(user)
    else
      user = User.new(name: params[:name])
      if user.save
        session[:user_id] = user.id
        flash[:success] = "User '#{user.name}' signed up and logged in!"
        redirect_to root_path
      else
        flash[:failure] = "Username invalid or does not exist. Please sign up below."
        redirect_to signup_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end

end
