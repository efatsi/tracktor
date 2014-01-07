class SetterUpper < Struct.new(:user)

  # ! because I'm excited!
  def self.set_it_up!(user)
    new(user).set_it_up!
  end

  def set_it_up!
    seed_database
    clean_old_time_entries
  end

  def seed_database
    HarvestSeeder.seed_projects_and_tasks(user)
  rescue DataObjects::SyntaxError # auto_migrate! if Project.count errors
    DataMapper.auto_migrate!
    HarvestSeeder.seed_projects_and_tasks(user)
  end

  def clean_old_time_entries
    TimeEntryCleaner.clean
  end

end
