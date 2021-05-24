class VotesController < ApplicationController

  def upvote
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash["alert alert-warning"] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: works_path)
    else
      @vote = Vote.new(work_id: work.id, user_id: user.id)

      if @vote.save
        success_message = "Successfully upvoted!"
        flash_success(success_message)
        redirect_back(fallback_location: works_path)
      else
        warning_message = "A problem occurred: Could not upvote"
        flash_warning(warning_message, @vote)
        redirect_back(fallback_location: works_path)
      end
    end
  end
end
