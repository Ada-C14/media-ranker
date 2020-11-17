class VotesController < ApplicationController

  def create
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      flash[:error] = "A problem occured: You must log in to do that"
    else
      @work = Work.find_by(id: params[:work_id])
      @vote = Vote.new(
          user_id: session[:user_id],
          work_id: @work.id
      )
      if @vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "Could not upvote"
      end
    end
    redirect_to works_path
    return
  end

end
