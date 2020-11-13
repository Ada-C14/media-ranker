class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def upvote

    if @vote.nil? && params[:work_id] && session[:user_id] # user is logged in
      @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
      if @vote.save
        flash[:success] = "Your vote for #{Work.find_by(id: params[:work_id]).title} has been counted!"
        redirect_to works_path
        return
      end
    elsif @vote.nil? && params[:work_id] && session[:user_id].nil? # user is not logged in
      flash[:error] = "You must be logged in to vote"
      redirect_to login_path
      return
    elsif @vote
      @vote = nil
      flash[:success] = "You removed your vote"
      redirect_to works_path
      return
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end