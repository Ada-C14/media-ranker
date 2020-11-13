class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def action_success_check(action, redirect_path, destination_view: :show)
    if action
      redirect_to redirect_path
    else
      render destination_view, status: :bad_request
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
