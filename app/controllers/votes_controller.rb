class VotesController < ApplicationController

  skip_before_action :require_login

  def create
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])
    print "#{session[:user_id]}"
    if work.nil?
      flash.now[:error] = "Work not found"
      head :not_found
      return
    elsif user.nil?
      flash.now[:error] = "User not found"
      head :not_found
      return
    elsif session[:user_id]
      @vote = Vote.create(work_id: work.id, user_id: user.id)

      if @vote.save
        flash[:success] = "Upvoted successfully"
        redirect_to work_path(work.id)
        return
      else
        flash.now[:error] = "You may only vote once per work"
        redirect_to work_path(work.id)
        return
      end
    end
  end

  def index
    @votes = Vote.all
  end

  def show
    if @vote.nil?
      head :not_found
      return
    end
  end

  # def edit
  # end

  # def new
  # end

  # def destroy
  # end

  # def update
  # end

end
