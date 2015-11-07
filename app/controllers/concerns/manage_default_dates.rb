module ManageDefaultDates
  extend ActiveSupport::Concern

  included do
    attr_reader :start_date
    attr_reader :end_date
  end

  #parses the date, it can return today, beginning_of_week or end_of_week
  def parse_date(date, date_type = :today)
    begin
      Time.zone.parse(date).to_date
    rescue
      case date_type
      when :today
        Date.current
      when :beginning
        Date.current.beginning_of_week
      when :end
        Date.current.end_of_week
      end
    end
  end

  def init_dates_range
    @start_date = parse_date(params[:start_date], :beginning)
    @end_date = parse_date(params[:end_date], :end)
  end

  def init_dates_today
    @start_date = parse_date(params[:start_date])
    @end_date = parse_date(params[:end_date])
  end
end
