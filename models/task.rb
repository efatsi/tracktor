class Task
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :harvest_id, Integer
  property :project_id, Integer

  validates_presence_of :name, :harvest_id, :project_id

  # belongs_to :project
  def project
    Project.first(:id => project_id)
  end

  def self.first_or_create(ticket_hash)
    first(:harvest_id => ticket_hash["id"], project_id => ticket_hash["project_id"]) ||
    create({
      :name       => ticket_hash["name"],
      :harvest_id => ticket_hash["id"],
      :project_id => ticket_hash["project_id"]
    })
  end

end
