class VotesController < ApplicationController

  def create
    if session[:user_id].nil?
      flash.now[:error]= "You need to be logged in to vote"
      return
    end
  end

  def upvote

    @work = Work.find_by(id: params[:work_id])

    @vote = Vote.new(
        user_id: session[:user_id],
        work_id: @work.id
    )

    if @vote.save
      flash[:success] = "You have successfully upvoted"
      redirect_to work_path(@work.id)
      return
    else
      flash[:error] = "There was an error with the vote"
      redirect_to work_path
      return
    end
  end
end

