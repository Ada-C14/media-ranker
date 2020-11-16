module ApplicationHelper
  def display_detail(detail)
    if (detail.is_a? String)
      return detail.empty? ? content_tag(:span, "Not Available", class: 'not_available')  : detail
    elsif(detail.is_a? Integer)
      return detail
    elsif detail.nil?
      return content_tag(:span, "N/A", class: 'not_available')
    else
      return detail
    end
  end

  def display_votes(vote_count)
    return vote_count == 1 ? "#{vote_count} Vote" : "#{vote_count} Votes"
  end
end
