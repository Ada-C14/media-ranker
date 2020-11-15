class VotesController < ApplicationController

  # before_action :require_login, only [:new, :create]

  def index
    @votes = Vote.all
  end


  def create
    @work = Work.find_by(id: params[:work_id])
    @vote = Vote.new(
        user_id: session[:user_id],
        work_id: @work.id
    )
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@work)
      return
    else
      flash[:error] = "A problem occurred: Could not upvote"
      redirect_to work_path(@work)
      return

  end
end


end
