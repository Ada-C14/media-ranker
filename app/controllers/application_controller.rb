class ApplicationController < ActionController::Base

  def flash_model_errors(model, problem_string, flash_now = true)
    if flash_now
      flash.now[:error] = ["A problem occurred: #{problem_string}"]
      flash.now[:error] << model.errors.messages
    else
      flash[:error] = ["A problem occurred: #{problem_string}"]
      flash[:error] << model.errors.messages
    end
  end

end
