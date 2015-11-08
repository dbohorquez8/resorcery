module ApplicationHelper
  # Outputs an array of dates to use by the date filter slider on the client.
  # Defaults to 2 weeks ago and 10 weeks ahead
  def default_dates
    start_date = 2.weeks.ago.to_date
    end_date = 4.weeks.from_now.to_date

    current_date = start_date
    default_dates = []
    while current_date < end_date
      default_dates << current_date
      current_date = current_date.advance(days: 1)
    end
    default_dates
  end
end
