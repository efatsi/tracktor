class HarvestSeeder < Struct.new(:user)

  def self.seed_projects_and_tasks(user)
    seeder = new(user)

    seeder.seed_projects_and_tasks
    seeder.clear_out_old_things
  end

  def seed_projects_and_tasks
    harvest_data.each do |project_json|
      project = Project.first_or_create(project_json, user)

      project_json["tasks"].each do |task_json|
        Task.first_or_create(task_json.merge("project_id" => project.id))
      end
    end
  end

  def clear_out_old_things
    project_ids = harvest_data.map{|p| p['id']}
    task_ids    = harvest_data.flat_map{|p| p['tasks'].map{|t| t['id']}}

    user.projects.all.each do |project|
      project.destroy unless project_ids.include?(project.harvest_id)
    end

    user.tasks.all.each do |task|
      task.destroy unless task_ids.include?(task.harvest_id)
    end
  end

  private

  def harvest_data
    @harvest_data ||= response["projects"]
  end

  def response
    JSON.parse(raw_response.parsed_response)
  end

  def raw_response
    user.client.projects.send(:request, :get, user.client.credentials, '/daily')
  end

end
