class Resource < ActiveRecord::Base
  include Colorizable
  acts_as_taggable

  validates :workspace_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: {scope: :workspace_id}

  belongs_to :workspace, class_name: "Workspace", foreign_key: :workspace_id, inverse_of: :resources
  counter_culture :workspace

  has_many :allocations, inverse_of: :resource

  # this method will return the availability of a given resource.
  #2015-09-01 year-month-day
  PREFERRED_DATE_FORMAT = "%Y-%m-%d"
  PREFERRED_HUMAN_DATE_FORMAT = "%b %d, %Y"
  def fetch_availability(options = {})
    start_date = options.with_indifferent_access[:start_date] || Date.current
    current_allocations = allocations.where("start_date >= :start_date", start_date: start_date)

    results = []
    date = start_date

    # if there are no allocations lets just return the open end range
    if current_allocations.empty?
      results.push(time_entry(start_date, 'anytime'))
    end

    current_allocations.each do |allocation|
      if date < allocation.start_date
        results.push(time_entry(date, allocation.start_date - 1.day))
      end
      date = allocation.end_date + 1.day
    end

    results.push(time_entry(date,'anytime'))

    results.uniq.first(5)
  end

  def time_entry(start_date, end_date)
    {
      start_date: preferred_format(start_date),
      end_date: preferred_format(end_date),
      human_start_date: preferred_human_format(start_date),
      human_end_date: preferred_human_format(end_date)
    }
  end

  # returns the date in the format I want to show it
  def preferred_format(date)
    return date if date == "anytime"
    date.strftime(PREFERRED_DATE_FORMAT)
  end

  # returns the date in the humnan format I want to show it
  def preferred_human_format(date)
    return date if date == "anytime"
    date.strftime(PREFERRED_HUMAN_DATE_FORMAT)
  end
end

