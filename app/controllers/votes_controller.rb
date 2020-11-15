class VotesController < ApplicationController

  def upvote
    if session[:user_id].nil?
      flash[:error] = ["A problem occurred: You must log in to do that"]
      redirect_back fallback_location: root_path
      return
    end
    @vote = Vote.connect_work_user(params[:work_id], session[:user_id])
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back fallback_location: root_path
      return
    else
      flash[:error] = ["A problem occurred: Could not upvote"]
      flash[:error] << @vote.format_errors
      redirect_back fallback_location: root_path
      return
    end
  end

  # def request_controller
  #   params[:controller]
  # end
end
