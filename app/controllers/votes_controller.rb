class VotesController < ApplicationController

  before_action :require_login, only: [:create]

  def new
    @vote = Vote.new
  end

  def create
    work_id = params[:work_id]  # dry up all instances of this
    work = Work.find_by(id: work_id)

    user = User.find_by(id: session[:user_id])

    @vote = Vote.new(work_id: work.id, user_id: user.id)


    if @vote.save
      flash[:success] = "Successfully upvoted"
      redirect_to work_path(work.id)
    else
      flash[:error] = "There was a problem with counting your vote"
      redirect_to work_path(work.id)
    end

  end


  private

  # Strong Params: https://learn-2.galvanize.com/cohorts/2036/blocks/1006/content_files/intro-to-rails/strong-params.md

end
