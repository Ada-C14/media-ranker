class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def action_success_check(action, redirect_path, destination_view: :show, success_msg: "Action Successful", error_msg: "Error - input invalid")
    if action
      flash[:success] = success_msg
      redirect_to redirect_path
    else
      flash.now[:error] = error_msg
      render destination_view, status: :bad_request
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def error_flash(failed_action,errors = nil)
    error_flsh = Hash.new
    error_flsh[:failed_action] = failed_action
    error_flsh[:errors] = errors ? errors.messages.map{|error_type, msg| "#{error_type.to_s.gsub('_', ' ')}: #{msg.join(" ")}" unless msg.empty?} : []
    error_flsh
  end
end


