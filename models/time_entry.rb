class TimeEntry
  include DataMapper::Resource

  property :id, Serial
  property :date, Date
  property :plant_id, Integer
  property :harvest_id, Integer

  validates_presence_of :date, :plant_id, :harvest_id

  # belongs_to :plant
  # don't need `plant` method I believe

  def self.first_or_create(plant)
    todays_time_entries.first(:plant_id => plant.id) || create({
      :date     => Date.today,
      :plant_id => plant.id
    })
  end

  def self.for_today
    all(:date => Date.today)
  end

end
