class ApplicationController < ActionController::Base
  def flash_success(success_message)
    flash["alert alert-success"] = success_message
  end

  def flash_warning(warning_message, category)
    flash["alert alert-warning"] = warning_message
    flash["alert alert-warning2"] = category.errors.first[1]
  end
end

