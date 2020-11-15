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
end

class ErrorFlash
  attr_reader :failed_action, :error_messages
  def initialize(failed_action,errors)
    @failed_action = "A problem occurred. could not #{failed_action}"
    @error_messages = errors.messages.map{|error_type, msg| "#{error_type}: #{msg.join(" ")}" unless msg.empty?}
  end
end
