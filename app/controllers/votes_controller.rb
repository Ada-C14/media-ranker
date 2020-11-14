class VotesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])

    if user.nil?
      flash[:error] = "A problem occured: You must log in to do that"
      redirect_to works_path
      return
    end

    if work.nil?
      flash[:error] = "A problem occured"
      return
    end

    @vote = Vote.new(
        work_id: work.id,
        user_id: user.id
    )
    if @vote.save
      flash[:success] = "Successfully upvoted"
    else
      flash[:error] = ["Aproblem occured: user has already voted for this work"]
    end
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
