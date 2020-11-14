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

  #########################################################

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

  # Custom actions
  def login_form
    @user = User.new
  end

  def login
    # if params[:username].present?
    #   username = params[:username]
    #   user_params = { username: username }
    # elsif params[:user].present?
    #   username = params[:user][:username]
    # else
    #   not_saved_error_notice('create')
    #   render :login_form
    #   return
    # end
    #
    # user = User.find_by(username: username)
    #
    # if user
    #   successful_login('existing', user)
    # else
    #   user = User.new(user_params)
    #   if user.save
    #     successful_login('new', user)
    #   else
    #     not_saved_error_notice('create')
    #     render :login_form
    #     return
    #   end
    # end
    #
    # session[:user_id] = user.id
    # redirect_to root_path
    # return

    username = user_params[:username]
    user = User.find_by(username: username)

    if user
      successful_login('existing', user)
    else
      user = User.new(user_params)
      if user.save
        successful_login('new', user)
      else
        not_saved_error_notice('create')
        redirect_back(fallback_location: root_path)
        return
      end
    end

    session[:user_id] = user.id
    redirect_to root_path
    return
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      user ? flash[:success] = 'Successfully logged out' : flash[:notice] = 'Error: unknown user'
      session[:user_id] = nil
    else
      authentication_notice
    end

    redirect_to root_path
  end

  def current
    @user = verify_login

    unless @user
      authentication_notice
      redirect_back(fallback_location: root_path)
      return
    end
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

end
