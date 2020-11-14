class VotesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])

    session[:return_to] = request.referer

    if user.nil?
      flash[:error] = "You must be logged in to vote on works"
      redirect_back(fallback_location: root_path)
      return
    end

    if work.nil?
      flash[:error] = "Could not locate work"
      redirect_back(fallback_location: root_path)
      return
    end

    @vote = Vote.new
    @vote.user_id = user.id
    @vote.work_id = work.id



    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
      return
    else
      flash[:error] = "A problem occurred: could not upvote. User can only upvote a work once"
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
