class TimeEntry
  include DataMapper::Resource

  property :id, Serial
  property :date, Date
  property :plant_id, Integer
  property :task_id, Integer
  property :harvest_id, Integer

  validates_presence_of :date, :plant_id, :harvest_id, :task_id

  def self.for_today
    all(:date => Time.zone.now.to_date)
  end

  belongs_to :plant
end
