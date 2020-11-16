class VotesController < ApplicationController
  before_action :require_login

  def index
    @vote = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(user_id: session[:user_id], work_id: params[:id])

    Vote.where(work_id: params[:id]).each do |vote|
      if vote.user_id == session[:user_id]
        flash[:error] = "Has already voted for this work"
        return
      end
    end

    if @vote.save
      flash[:success] = "Successfully upvoted!"

      if @vote.work.votes == nil
        @vote.work.votes = []
      else
        @vote.work.votes << @vote
      end

      @vote.work.save ##### Is save necessary here????????

      redirect_to work_path(@vote.work_id)
      return
    else
      flash.now[:error] = "Sorry, upvote failed."
      #render status: :bad_request
    end
  end

  def require_login
    if current_user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to login_path
      return
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id, :created_at)
  end
end
