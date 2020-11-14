class VotesController < ApplicationController
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

    if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back fallback_location: work_path(work.id)
    else
        flash[:error] = "Problem occurred: could not upvote.
                         Looks like you've already voted for this work!"
        redirect_back fallback_location: work_path(work.id)
    end
    
  end

end
