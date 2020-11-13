class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    # TODO:
    # if @user.nil?
    #   # here need to redirect to an error page
    # end
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user.name}"
    else
      user = User.new(name: name)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Successfully created new user #{user.name} with ID #{user.id}"
      else
        flash.now[:error] = "A problem occurred: Could not login"
        render :login_form
        return
         # flash[:error_message] = 
      end
    end

  redirect_to root_path
  return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end
end
