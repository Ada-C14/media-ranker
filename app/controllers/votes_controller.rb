class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(params[vote_params])
    if @vote.save
      redirect_to work_path
      return
      else
        flash[:error] = "Vote not saved, please login to vote."
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
