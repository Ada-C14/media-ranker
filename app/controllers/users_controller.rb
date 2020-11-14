class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:user][:name])
    if @user.save
      flash[:success] = "#{@user.name} was successfully created :)"
      redirect_to user_path(@user.id)
      return
    else
      flash.now[:error] = "#{@user.name} was NOT successfully added :("
      render :new
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(name: params[:user][:name])
      if user
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as returning user #{user.name}"
      else
        user = User.create(name: params[:user][:name])
        if user
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as new user #{user.name}"
      end
    # if @user.nil?
    #   user = User.new(name: params[:user][:name])
    #   if ! user.save
    #     flash[:error] = "Unable to Login"
    #     redirect_to root_path
    #   end
    #   flash[:welcome] = "Welcome #{user.name}"
    # else
    #   flash[:welcome] = "Welcome back #{user.name}"
    # end
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end

  # def logout
  #   if session[:user_id]
  #     user = User.find_by(id: session[:user_id])
  #     unless user.nil?
  #       session[:user_id] = nil
  #       flash[:notice] = "Goodbye #{user.name}"
  #     else
  #       session[:user_id] = nil
  #       flash[:notice] = "Error Unknown User"
  #     end
  #   else
  #     session[:user_id] = nil?
  #     flash[:error] = "You must be Logged In to Logout"
  #   end
  #   redirect_to root_path
  # end
end
