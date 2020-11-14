class VotesController < ApplicationController
  def create
    @current_user = User.find_by(id: session[:user_id])

    if @current_user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: :back)
      return
    end

    work = Work.find_by(id: params[:work_id])
    if work.nil?
      head :not_found
      return
    end

    @vote = Vote.new(work_id: work.id, user_id: @current_user.id)

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: :back)
      return
    else
      flash[:error] = "A problem occurred: Could not upvote"
      flash[:reason] = "user: has already voted for this work"
      redirect_back(fallback_location: :back)
      return
    end
  end
end
