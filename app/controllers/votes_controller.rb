class VotesController < ApplicationController
  # before_action :require_login, only: [:create]

  def create
    if !session[:user_id]
      flash[:failure] = "A problem occurred: You must log in to do that"
      redirect_to works_path
      return
    else
     @user = User.find_by(id: session[:user_id])
     work_id = params[:work_id]
     user_id = @user.id

     vote = Vote.new(user_id: user_id, work_id: work_id)

     if Vote.where(user_id: vote.user_id, work_id: vote.work_id).count.zero?
       saved = vote.save
       if saved
         flash[:success] = "Successfully upvoted!"
         redirect_to work_path(work_id)
         return
       else
         flash[:failure] = "Unable to upvote at this time! 👾🔥👾🔥👾"
       end
     else
       flash[:error] = "A problem occurred: Could not upvote - #{@user.username}: has already voted for this work"
       redirect_to work_path(work_id)
       return
     end
    end
  end
end


private
def vote_params
  params.permit(:user_id, :work_id)
end