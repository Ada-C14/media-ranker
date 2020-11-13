class VotesController < ApplicationController
  before_action :require_login, only: [:create]
  def index
    @votes = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])

    @vote = Vote.new(work_id: work.id, user_id: user.id)
    if @vote.voted?
      flash[:error] = "A problem occurred: Could not upvote. User has already voted for this work"
      redirect_back(fallback_location: root_path)
      return
    end

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back fallback_location: work_path(work.id)
    else
      flash[:error] = "Saving failed."
      redirect_back fallback_location: work_path(work.id)
    end

  end
end
