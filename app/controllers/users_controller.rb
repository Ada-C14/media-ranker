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
      flash[:success] = "User #{@user.username} has successfully signed up and logged in!"
      redirect_to root_path
    else
      flash.now[:failure] = "Error: user could not be saved."
      render :new, status: 400
    end
  end

  private

  def user_params
    return params.require(:user).permit(
        :username
    )
  end
  def find_user_works
    @user_votes = User.find_by(id: params[:id]).votes
  end
end
