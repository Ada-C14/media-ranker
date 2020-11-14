class VotesController < ApplicationController

  def create
    # work nested route
    work_id = params[:work_id]
    work = Work.find_by(id: work_id)

    if session[:user_id].nil?
      flash[:error] = "A problem occurred: You must log in to do that"
    else
      @vote = work.upvote(session[:user_id])
      if @vote.save
        flash[:success] = "Successfully Upvoted"
      else
        flash[:error] = "A problem occurred: Could not upvote"
      end

    end
      redirect_back fallback_location: root_path
    return
  end

end
