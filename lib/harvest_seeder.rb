class HarvestSeeder

  def self.seed_projects_and_tasks
    new.seed_projects_and_tasks
  end

  def seed_projects_and_tasks
    harvest_projects.each do |project_json|
      project = Project.first_or_create(project_json)

      project_json["tasks"].each do |task_json|
        Task.first_or_create(task_json.merge("project_id" => project.id))
      end
    end
  end

  private

  def harvest_projects
    response["projects"]
  end

  def response
    JSON.parse(raw_response.parsed_response)
  end

  def raw_response
    client.projects.send(:request, :get, client.credentials, '/daily')
  end

end
