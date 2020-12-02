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
      #new user
      user = User.create(name: params[:user][:name])
      if !user.save #not able to save user
        flash[:error] = "unable to log in"
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{user.name}"  #able to save user
    else
      # existing user
      flash[:welcome] = "Welcome back #{user.name}"  #existing user
    end

    session[:user_id] = user.id  #save user id to session
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{user.name}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error unkown user"
      end
    else
      flash[:error] = "You must be logged in to log out"
    end
    redirect_to root_path
  end

  def current
    user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
      return
    end
  end
end







