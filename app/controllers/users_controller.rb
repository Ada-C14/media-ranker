class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = find_by_id

    if @user.nil?
      head :not_found
      return
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
      return
    else
      render :new, status: :bad_request
      return
    end
  end

end
