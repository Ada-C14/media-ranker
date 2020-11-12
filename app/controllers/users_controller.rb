class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    # if username is existed, flash "Successfully logged in as existing user Cinnamon Toast" and redirect to root_path
    if @user.save
      flash[:success] = "Successfully created new user #{ params[:username] } with ID #{ params[:id] }"
      redirect_to root_path
      return
    else
      # if no username is provided + errors.message on view
      # title is sensitive to up/lowercase, but up/lowercase are two different users. 
      flash.now[:error] = "A problem occurred: Could not log in"
      render :new, status: :bad_request 
      return
    end
  end

  private
  def user_params
    return params.require(:user).permit(:username, :joined).tap { |user| user[:joined] = Time.now.strftime("%b %d, %Y") }
  end
end
