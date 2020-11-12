class VotesController < ApplicationController
  before_action :require_login

  def upvote
    @work = Work.find_by(id: params[:work_id])

    @vote = Vote.new(
        user_id: session[:user_id],
        work_id: @work.id
    )

    if @vote.save
      flash[:success] = "Successfully upvoted"
      redirect_to work_path(@work.id)
    else
      flash[:error] = @vote.errors.messages[:user_id][0]
      redirect_back fallback_location: works_path
    end
  end

  private

  def require_login
    unless session[:user_id]
      flash[:error] = "You must be logged in to vote"
      redirect_back fallback_location: login_path
    end
  end
end
