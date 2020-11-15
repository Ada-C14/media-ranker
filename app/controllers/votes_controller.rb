class VotesController < ApplicationController
  def create
    @vote = Vote.new(params[])
    if @vote.save
      redirect_to work_path
      else flash[error] = "Vote did not save"
    end
  end
end
