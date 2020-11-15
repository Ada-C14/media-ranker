class VotesController < ApplicationController

  def create
    @vote = Vote.create(work_id: params[:id],user_id: session[:user_id])
    if session[:user_id] && @vote.valid?
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: :back)
    elsif @vote.valid? == false
      flash[:warning] = "You have already voted for this work"
      redirect_back(fallback_location: :back)
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end
end
