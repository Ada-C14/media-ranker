class VotesController < ApplicationController

  before_action :require_login

  def create
    @vote = Vote.create(work_id: params[:id],user_id: session[:user_id])
    if session[:user_id] && @vote.valid?
      flash[:success] = "Thanks for voting for this work!"
      redirect_back(fallback_location: :back)
    elsif @vote.valid? == false
      flash[:error] = "You've already voted for this work!"
      redirect_back(fallback_location: :back)
    end
  end
end
