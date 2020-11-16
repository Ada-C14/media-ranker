class VotesController < ApplicationController

  # Controller filter method is in application controller.
  before_action :find_user_logged_in, only: [:create]

  def create
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
