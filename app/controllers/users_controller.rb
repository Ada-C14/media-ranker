class UsersController < ApplicationController
  def index
    @users = User.order # list all users in order
  end
end
