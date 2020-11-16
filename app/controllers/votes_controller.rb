class VotesController < ApplicationController
  def create
    @work = Work.find_by(id: params[:work_id])

    if current_user.nil?
      flash[:warning] = "You must be logged in to vote."
      return
    end

    if @work.votes.find_by(user_id: current_user.id)
      flash[:warning] = "Invalid request. You already voted for this work."
      redirect_to works_path
      return

    else
      vote = Vote.create(
          user_id: current_user.id,
          work_id: params[:work_id]
      )

      if  vote.id
        flash[:success] = "Vote accepted!"
        redirect_to works_path
        return
      else
        flash[:warning] = "Upvote failed."
      end
    end
  end

  def destroy
    vote_id = params[:id]
    @vote = Vote.find_by(id: vote_id)

    if @vote.nil?
      head :not_found
      return
    end

    if @vote.destroy
      flash[:success] = "Successfully deleted."
      redirect_to works_path
      return
    else
      flash[:warning] = "Cannot delete."
      redirect_to works_path
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
