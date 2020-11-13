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
    @user = User.find_by(id: session[:user_id])

    unless @user
      authentication_notice
      redirect_back(fallback_location: root_path)
      return
    end

    # some user vote check here
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
