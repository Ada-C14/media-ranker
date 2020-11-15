class VotesController < ApplicationController

  def upvote
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])

    if @user.nil? # user is not logged in
      flash[:error] = "You must be logged in to vote"
      redirect_to login_path
      return
    end

    if @work.nil? # invalid work
      flash[:error] = "This work does not exist!"
      redirect_to works_path
      return
    end

    @vote = Vote.new(user: @user, work: @work)
    if @vote.save
      flash[:success] = "Your vote for #{@work.title} has been counted!"
      redirect_to works_path
      return
    else
      flash[:failure] = "You can't vote for #{@work.title} more than once!"
      redirect_to works_path
      return
    end
  end

  def destroy
    @vote = Vote.find_by(id: params[:id])

    if @vote.nil?
      head :not_found
      return
    else
      @vote.destroy
      redirect_to current_user_path
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end