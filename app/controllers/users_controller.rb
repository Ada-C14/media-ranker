class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
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
      redirect_to user_path(@user.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to users_path
      return
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    elsif @user.update(user_params)
      flash[:success] = "user updated successfully"
      redirect_to user_path # go to the show so we can see the user
      return
    else # save failed :(
    flash.now[:error] = "Something happened. user not updated."
    render :edit, status: :bad_request # show the new user form view again
    return
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to users_path
      return
    else
      @user.destroy
      redirect_to users_path
    end
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
