class TimeEntryCreator < Struct.new(:plant)

  def self.create(plant)
    new(plant).create
  end

  def create
    TimeEntry.create({
      :date       => Date.today,
      :plant_id   => plant.id,
      :harvest_id => new_harvest_timer.id
    })
  end

  private

  def new_harvest_timer
    client.time.create({
      "project_id" => project.harvest_id, "task_id" => task.harvest_id
    })
  end

  def project
    task.project
  end

  def task
    @task ||= plant.task
  end

end
