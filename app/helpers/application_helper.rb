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

  def readable_date(date)
    return "[unknown]" unless date

    return content_tag(:span, "#{time_ago_in_words(date)} ago", class: 'date', title: date.to_s)
  end
end
