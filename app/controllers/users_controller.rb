class UsersController < ApplicationController
  def index
    # @users = User.order(date_joined :asc)
    @user = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

end


