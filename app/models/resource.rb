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
  def fetch_availability(options = {})
    start_date = options.with_indifferent_access[:start_date] || Date.current
    current_allocations = allocations.where("start_date >= :start_date", start_date: start_date)

    results = []
    date = start_date

    # if there are no allocations lets just return the open end range
    if current_allocations.empty?
      results.push({start: preferred_format(start_date), end: 'anytime'})
    end

    current_allocations.each do |allocation|
      if date < allocation.start_date
        results.push({start: preferred_format(date), end: preferred_format(allocation.start_date - 1.day)})
      end
      date = allocation.end_date + 1.day
    end

    results.push({start: preferred_format(date), end: 'anytime'})

    results
  end

  # returns the date in the format I want to show it
  def preferred_format(date)
    date.strftime(PREFERRED_DATE_FORMAT)
  end
end

