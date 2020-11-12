class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      return
    else
      flash[:error] = "Something happened, vote not saved"
      return
    end
  end
end
