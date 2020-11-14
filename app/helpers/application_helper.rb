module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :success
      "alert-success"
    when :error
      "alert-warning"
    when :warning
      "alert-warning"
    end
  end
end
