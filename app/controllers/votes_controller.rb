class VotesController < ApplicationController

  def create
    if session[:user_id].nil?
      flash.now[:error] = "You need to be logged in to do that"
      return
    end

    @vote = Vote.connect_work_user(params[:work_id], session[:user_id])

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back fallback_location: root_path
      return
    else
      # flash[:error] = "A problem occured: Could not upvote"
      redirect_back fallback_location: root_path, status: :bad_request
      return
    end
  end

  def request_controller
    params[:controller]
  end
end
