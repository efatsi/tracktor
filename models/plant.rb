class Plant
  include DataMapper::Resource

  property :id, Serial
  property :button, Integer
  property :task_id, Integer

  validates_presence_of :button, :task_id

  def self.first_or_new(button)
    first(:button => button) || new(:button => button)
  end

  # belongs_to :task
  def task
    Task.first(:id => task_id)
  end

  # has_one :time_entry
  def existing_time_entry
    @existing_time_entry ||= TimeEntry.for_today.first({
      :plant_id => id,
      :task_id  => task_id
    })
  end

  def new_time_entry
    TimeEntryCreator.create(self)
  end
end
