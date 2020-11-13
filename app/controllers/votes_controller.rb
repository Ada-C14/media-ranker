class VotesController < ApplicationController

  # def create
  #   vote = Vote.find_by(work_id: self.id )
  #   return vote.created_at.strftime('%b %d, %Y')
  # end
  #
  # def upvote
  #   user = User.find_by(id: session[:user_id])
  #   user_id = user.id
  #   vote = Vote.new(user_id: user_id, work_id: params[:work_id])
  #
  #   if user.nil?
  #     flash[:error] = "A problem occured: You must log in to do that"
  #     redirect_to works_path
  #     return
  #   end
  #
  #   if vote.save
  #     flash[:success] = "Successfully upvoted"
  #     # redirect_to works_path
  #     redirect_to works_path
  #     return
  #   else
  #     flash[:error] = "Could not upvote"
  #     redirect_to works_path
  #   end
  # end

  private

  def work_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
