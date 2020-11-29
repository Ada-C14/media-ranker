class UsersController < ApplicationController

  def index
    @users = User.all.order(:created_at)
  end

  def new
    @user = User.new()
  end

  def show
    @user = User.find_by(id: params[:id])
    @votes = Vote.find(@user.votes.ids)
    if @user == nil
      flash.now[:failure]
      render status: :not_found    # 'layouts/invalid_page' ??,
    end
  end

  def create
    # filtered_user_params = user_params()
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User #{@user.name} has successfully signed up and logged in!"
      redirect_to root_path
    else
      flash.now[:failure] = "Error: user could not be saved."
      render :new, status: 400
    end
  end

  def login
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

  def login_form; end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(
        :name
    )
  end
  def find_user_works
    @user_votes = User.find_by(id: params[:id]).votes
  end

end

