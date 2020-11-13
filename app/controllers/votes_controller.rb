class VotesController < ApplicationController
  def upvote
    # @vote = Vote.find_by(id: params[:id])
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])
    @vote = Vote.new(user_id: user.id, work_id: work.id)

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(work.id)
      return
    else
      flash[:warning] = "A problem occurred: Could not upvote"
      redirect_to work_path(work.id)
      return
    end
  end
end
