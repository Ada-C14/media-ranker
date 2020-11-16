class VotesController < ApplicationController
  before_action :find_work, only: [:create, :destroy]

  def create
    case @work.vote_button(@current_user)
    when "Vote!"
      if Vote.create(user_id: session[:user_id], work_id: params[:work_id])
        flash[:success] = "Successfully upvoted!"
      else
        flash[:failure] = "Something bad happened. Vote not created."
      end
    when "Remove Vote"
      flash[:warning] = "Vote not created. You have already upvoted this work."
    when nil
      flash[:warning] = "Vote not created. You must be logged in to do that!"
    end
    redirect_to work_path(params[:work_id])
  end

  def destroy
    @vote = Vote.find_by(id: params[:id])
    case @work.vote_button(@current_user)
    when "Vote!"
      flash[:warning] = "Vote not deleted. You haven't yet upvoted this work."
    when "Remove Vote"
      if @vote.destroy
        flash[:success] = "Successfully removed upvote!"
      else
        flash[:failure] = "Something bad happened. Vote not deleted."
      end
    when nil
      flash[:warning] = "Vote not deleted. You must be logged in to do that!"
    end
    redirect_to work_path(params[:work_id])
  end

  private

  def find_work
    @work = Work.find_by(id: params[:work_id])
    if @work.nil?
      flash.now[:warning] = "Not found! Try again?"
      render :notfound, status: :not_found
    end
  end

end
