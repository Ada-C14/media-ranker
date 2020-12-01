module ApplicationHelper
    def custom_title
        title = link_to "Media Ranker", root_path + " | Ranking the Best of Everything"
    end

    def readable_date(date)
        date.strftime("%b %e, %Y")
    end
end
