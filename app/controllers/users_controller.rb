class UsersController < ApplicationController
  def index
    # @users = User.order(joined_date :asc)
    @user = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      user = User.new(name: params[:user][:name], date_joined: Date.today)
      session[:user_id] = user.id
      if !user.save

      end

      flash[:success] = "Successfully logged in as new user: #{user.name}"


      session[:user_id] = user.id #setting the session id to the user_id
      flash[:success] = "Successfully logged in as returning user: #{user.name}"
    else
      #new user

    end
    redirect_to root_path
    return
  end

  def logout
    @current_user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    redirect_to root_path
  end
end

