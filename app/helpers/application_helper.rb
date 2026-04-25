module ApplicationHelper
    def smart_time(datetime)
        if datetime > 7.days.ago
            time_ago_in_words(datetime) + " ago"
        else
            datetime.strftime("%B %d, %Y")
        end
    end
end
