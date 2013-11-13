class Plant
  include DataMapper::Resource

  property :id, Serial
  property :button, Integer
  property :task_id, Integer
  property :user_id, Integer

  validates_presence_of :button, :task_id

  belongs_to :task
  belongs_to :user

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
