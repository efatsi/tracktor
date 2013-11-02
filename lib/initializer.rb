class Initializer

  # ! because I'm excited!
  def self.set_it_up!
    set_up_database
    set_up_time_entries
  end

  def self.set_up_database
    begin
      if Project.count == 0 || Task.count == 0
        HarvestSeeder.seed_projects_and_tasks
      end
    rescue DataObjects::SyntaxError # auto_migrate! if Project.count errors
      DataMapper.auto_migrate!
      HarvestSeeder.seed_projects_and_tasks
    end
  end

  def self.set_up_time_entries
    TimeEntryCleaner.clean
  end

end
