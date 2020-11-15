class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      # Change this to a 404 page
      redirect_to root
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have joined the ranker!"
      # @user or @user.id ?
      redirect_to user_path(@user.id)
      return
    else
      flash.now[:error] = "There's been an error. We couldn't add you to the system."
      render :new, status: :bad_request
      return
    end
  end

  private

  def user_params
    return params.require(:user).permit(:user_name, :join_date)
  end

end
