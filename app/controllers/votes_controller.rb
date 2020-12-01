class VotesController < ApplicationController


  def show
  end

  def new
    @vote = Vote.new
  end

  def create
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "Please log in to upvote media."
      return
      redirect_back(fallback_location: root_path)
    else
      @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
    end

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
      return
    else
      flash[:error] = "A problem occurred: Could not upvote"
      redirect_back(fallback_location: root_path)
    end

  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
