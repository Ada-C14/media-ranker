class VotesController < ApplicationController

  def upvote
    @work = Work.find_by(id: params[:work][:id])
    @work.votes.create
    redirect_to(works_path)
  end
end
