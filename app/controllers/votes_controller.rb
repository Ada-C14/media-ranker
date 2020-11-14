class VotesController < ApplicationController

  before_action :require_login, only [:new, :create]

  def index
    @votes = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])

    @upvote = Vote.new(work_id: @work_id, user_id@current_user.id)



  end


end
