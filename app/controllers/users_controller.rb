class UsersController < ApplicationController

  def login_form
    @user = User.new
  end

  def login

  end

  def logout

  end

private

def user_params
  return params.require(:user).permit(:username)
end
end