class ApplicationController < ActionController::Base
  before_action :find_work
  before_action :find_current_user

  private

  def find_current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def find_work
    @work = Work.find_by(id: params[:work_id].to_i)
    if @work.nil?
      flash.now[:warning] = "Not found! Try again?"
      render :notfound, status: :not_found
    end
  end


end
