class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(params[:id])

  end

  def login

  end

  def logout

  end

  def create

  end
end
