class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      redirect_to root_path
      return
    else
      user = User.create(username: username)

      if user.save
        session[:user_id] = user.id
        flash[:success] = "Successfully created new user #{user.username} with ID #{user.id}"
        redirect_to root_path
        return
      else
        flash[:warning] = "A problem occurred: Could not login"
        flash[:messages] = user.errors.messages
        redirect_to login_form
        return
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

end