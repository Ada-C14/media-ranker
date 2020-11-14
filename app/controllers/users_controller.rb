class UsersController < ApplicationController
  def login_form # ???

  end

  def login
    @user = User.find_by(id: params[:id])
    # if @user.nil?
    #
    # elsif
    #
    # end

  end

  def logout

  end

  def current_user

  end
end
