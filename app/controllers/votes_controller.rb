class VotesController < ApplicationController
  before_action :require_login


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
      redirect_back fallback_location: works_path
      return
    else
      flash[:error] = "This user has already voted for this work."
      redirect_back fallback_location: works_path
      return

  end
end


end
