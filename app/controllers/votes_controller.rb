class VotesController < ApplicationController

  def upvote
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "User isn't logged in"
      redirect_to root_path
      return
    end
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
      flash[:warning] = "Problem occurred: user has already voted for this work."
      redirect_to work_path
      return
    end
  end
end

