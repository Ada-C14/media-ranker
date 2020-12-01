class UsersController < ApplicationController
  before_action :require_login, only: [:upvote]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    return head :not_found if @user.nil?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.title} was successfully added!"
      redirect_to User_path(@user.id)
      return
    else
      flash.now[:error] = "#{@user.title} was not successfully added!"
      render :new, status: :bad_request
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      user = User.new(name: params[:user][:name])
      if ! user.save
        flash[:error] = "Unable to login"
      end
      flash[:welcome] = "Welcome #{user.name}"
    else
      flash[:welcome] = "Welcome back #{user.name}"
    end

    session[:user_id] = user.id
    redirect_to root_path
    return
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:success] = "Goodbye #{user.name}! Until next time..."
      else
        session[:user_id] = nil
        flash[:notice] = "Error: Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end

  def current_user
    @user = User.find_by(id: session[:user_id])
    return @user
  end

  def upvote
    @user = current_user
    @work = Work.find_by(id: params[:id])
    @vote_exist = Vote.find_by(user_id: @user.id, work_id: @work.id )

    if @user && @work
      if @vote_exist
        flash[:error] = "Sorry, you have already cast your vote for this work."
      else
        new_vote = Vote.new({user_id: @user.id, work_id: @work.id})
        new_vote.save
        @work.increase_vote_count
        flash[:success] = "Your vote has been added!"
      end
    end
    redirect_to works_path
    return
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to vote."
      redirect_back(fallback_location:"/")
      return
    end
  end
end
