class UsersController < ApplicationController

  # Helper Methods
  def successful_login(type, user)
    flash[:success] =
        if type == 'new'
          "Successfully created user #{user.username} with ID #{user.id}"
        else
          "Successfully logged in as existing user #{user.username}"
        end
  end

  def not_saved_error_notice
    flash.now[:notice] = "Please try again, it was not save correctly"
  end

  def authentication_notice
    flash[:notice] = "Please log in to perform this action"
  end

  #########################################################


  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

      if user
        successful_login('existing', user)
      else
        user = User.new(username: params[:user][:username])
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
  end

  def logout
    if session[:user_id]
      user = User.get_session_user(session[:user_id])
      user ? flash[:success] = 'Successfully logged out' : flash[:notice] = 'Error: unknown user'
      session[:user_id] = nil
    else
      authentication_notice
    end
    redirect_to root_path
  end

  def current
    @user = User.get_session_user(session[:user_id])

    unless @user
      authentication_notice
      redirect_to root_path
      return
    end
  end

  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
    if @user.nil?
      not_found_error_notice
      return
    end
  end

end
