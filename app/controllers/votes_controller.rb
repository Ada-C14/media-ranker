class VotesController < ApplicationController

  def upvote
    @work = Work.find_by(id: params[:work][:id])
    @work.votes.create
    redirect_to(works_path)
  end
  def index

  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
