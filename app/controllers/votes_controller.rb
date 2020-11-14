class VotesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])

    if user.nil?
      flash.now[:error] = "You must be logged in to vote on works"
      render work_path(work.id)
    end

    @vote = Vote.new
    @vote.user_id = user.id
    @vote.work_id = work.id

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(work.id)
      return
    else
      flash.now[:error] = "A problem occurred: could not upvote"
      render :new, status: :bad_request
      return
    end
  end
end
