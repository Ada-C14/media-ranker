class VotesController < ApplicationController
  def upvote


    if params[:work_id]
      @work = Work.find_by(id: params[:work_id])

      if session[:user_id]
        @user = User.find_by(id: session[:user_id])

        @vote = Vote.new(work: @work, user: @user)

        if @vote.save
          flash[:success] = "Successfully upvoted!"
          redirect_back(fallback_location: root_path)
          return
        else
          flash[:error] = "A problem occurred: Could not upvote"
          session[:error] = @vote.errors
          redirect_back(fallback_location: root_path)
          end

      else
        flash[:error] = "A problem occurred: You must log in to do that"
        redirect_back(fallback_location: root_path)
        return
      end

    else
      head :not_found
      return
    end
  end
end
