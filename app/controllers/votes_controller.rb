class VotesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:error] = "You must be logged in to vote on works"
      redirect_to work_path(work.id)
    end

    work = Work.find_by(id: params[:work_id])
    if work.nil?
      flash[:error] = "Could not locate work"
      redirect_to works_path
    end

    @vote = Vote.new
    @vote.user_id = user.id
    @vote.work_id = work.id



    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@vote.work_id)
      return
    else
      flash[:error] = "A problem occurred: could not upvote. User can only upvote a work once"
      redirect_to work_path(@vote.work_id)
      return
    end
  end
end
