class UsersController < ApplicationController
  def index
    @users = User.order # list all users in order
  end

  def show
    @user = current_user
    if @user.nil?
      redirect_to users_path
      return
    end
  end

  # def create
  #   @user = current_user
  #   if @user.nil?
  #     redirect_to users_path
  #     return
  #   elsif @
  #   end


  # end

  def new
    @user = User.new
  end

  def destroy
  end
  
end

# .string "name"
#     t.string "creator"
#     t.string "category"
#     t.string "description"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.integer "publication_year"