class VotesController < ApplicationController
  # Helper Methods
  def successful_upvote
    flash[:success] = 'Successfully upvoted!'
  end

  def unsuccessful_upvote
    flash[:notice] = 'Something went wrong there - please try again.'
  end

  def already_voted
    flash[:notice] = "Looks like you've already voted for this work!"
  end

  #########################################################

  def create
    @user = verify_login

    unless @user
      authentication_notice
      redirect_back(fallback_location: root_path)
      return
    end

    if @user.includes_work?(params[:work_id])
      already_voted
    else
      vote = Vote.new(user_id: @user.id, work_id: params[:work_id])
      vote.save ? successful_upvote : unsuccessful_upvote
    end

    redirect_back(fallback_location: root_path)
    return
  end

  private

  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end
end
