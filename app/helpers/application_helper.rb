module ApplicationHelper
  def flash_class(level)
    { :success => "alert-success",
      :error => "alert-warning"
    } [level.to_sym] || level.to_s
  end  
end
