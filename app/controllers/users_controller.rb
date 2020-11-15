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
    name = params[:user][:name]
    user = User.find_by(name: name)

  end

  def logout

  end


end
