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
      redirect_to current_user_path(@user)
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def login_form

  end

  def login

  end

  def logout

  end

  def current

  end

  def find_by_id
    user_id = params[:id].to_i
    user = User.find_by(id: user_id)
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end

end
