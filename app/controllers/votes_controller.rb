class VotesController < ApplicationController

  def create
    # work nested route
    work_id = params[:work_id]
    @work = Work.find_by(id: work_id)

    if session[:user_id].nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to works_path
    end

  end

end
