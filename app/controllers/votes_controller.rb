class VotesController < ApplicationController

  before_action :require_login, only [:new, :create]

  def upvote
    @work_id = params[:work_id]
    vote = Vote.new
    vote.work_id = @work_id
    vote.user_id = @current_user.id
  end


end
