class VotesController < ApplicationController
  # Helper Methods
  def successful_upvote
    flash[:success] = 'Successfully upvoted!'
  end

  def unsuccessful_upvote
    flash[:notice] = 'Something went wrong there - please try again.'
  end

  #########################################################

  def create
    raise
    # if params[:work_id]
    #   vote = Vote.new(vote_params)
    #   vote.save ? successful_upvote : unsuccessful_upvote
    # else
    #
    # end

    redirect_back(fallback_location: root_path)
  end

  private

  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end
end
