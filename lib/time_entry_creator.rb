class TimeEntryCreator < Struct.new(:plant)

  def self.create(plant)
    new(plant).create
  end

  def create
    if existing_harvest_timer
      TimeEntryToggler.toggle_timer(new_time_entry, plant.user)
    else
      new_time_entry
    end
  end

  private

  def new_time_entry
    TimeEntry.create({
      :date       => Date.today,
      :plant_id   => plant.id,
      :harvest_id => harvest_timer.id,
      :task_id    => plant.task_id
    })
  end

  def harvest_timer
    existing_harvest_timer || new_harvest_timer
  end

  def new_harvest_timer
    client.time.create({
      "project_id" => project.harvest_id, "task_id" => task.harvest_id
    })
  end

  def existing_harvest_timer
    return @existing_harvest_timer if defined? @existing_harvest_timer

    @existing_harvest_timer = client.time.all.detect do |timer|
      timer.project_id.to_i == project.harvest_id &&
      timer.task_id.to_i    == task.harvest_id
    end
  end

  def project
    task.project
  end

  def task
    @task ||= plant.task
  end

  def client
    @client ||= plant.user.client
  end

end
