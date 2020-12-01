class VotesController < ApplicationController
  before_action :require_login, only: [:create]

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.create(work_id: params[:id],user_id: session[:user_id])

    if session[:user_id] && @vote.valid?
      flash[:success] = "You have VOTED!"
      redirect_to root_path
    else
      flash[:error] = "Only one vote per media, sorry!"
      redirect_to root_path
    end
  end
end
