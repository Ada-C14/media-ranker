class VotesController < ApplicationController

  def create
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      flash[:error] = "A problem occured: You must log in to do that"
      redirect_back fallback_location: works_path
      return
    else
      @work = Work.find_by(id: params[:work_id])
      @vote = Vote.new(
          user_id: @current_user.id,
          work_id: @work.id
      )
      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back fallback_location: works_path
        return
      else
        flash[:error] = "Could not upvote"
        redirect_back fallback_location: works_path
        return
      end
    end
  end

end
