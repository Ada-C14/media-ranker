# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :require_login

  # def upvote
  #   if @work.nil?
  #     redirect_to root_path
  #     return
  #   elsif !Work.exists?(work_id)
  #     redirect_to root_path
  #     flash[:error] = "This work does not exist."
  #     return
  #   elsif Vote.exists?(session[:user_id], work_id)
  #     redirect_to root_path
  #     flash[:error] = "You have already voted for this work."
  #   else
  #     @vote = Vote.new(user_id: session[:user_id], work_id: work_id)
  #     @vote.save
  #     render :show
  #   end
  # end

  def upvote
    @work = Work.find_by(id: params[:work_id])
    @vote = Vote.new(
      user_id: session[:user_id],
      work_id: @work.id
    )
    if @vote.save
      flash[:success] = 'Upvote successful!'
      redirect_to work_path(@work.id)
    else
      flash[:error] = @vote.errors.messages[:user_id][0]
      redirect_to works_path
    end
  end


  private

  def require_login
    unless session[:user_id]
      flash[:error] = "You must be logged in to vote"
      redirect_back fallback_location: login_path
    end
  end

end
