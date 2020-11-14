class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
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
      user = User.new(name: params[:user][:name])
      if ! user.save
        flash[:error] = "Unable to login"
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{user.name}"
    else
      #existing user
      flash[:welcome] = "Welcome back #{user.name}"
    end

    session[:user_id] = user.id
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
        flash[:notice] = "Error unknown user"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end

    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
      return
    end
  end

  def vote
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
      return
    end

    @vote = Vote.create(work_id: params[:work_id], user_id: user.id)
    if not @vote.valid?
      flash[:error] = "You can't vote more than once for each media"
    end

    redirect_back(fallback_location: root_path)
  end


  private

  def user_params
    params.require(:user).permit(:name)
  end
end
