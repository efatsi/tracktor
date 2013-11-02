class Project
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :harvest_id, Integer
  property :client_name, String

  validates_presence_of :name, :harvest_id, :client_name

  # has_many :tasks
  def tasks
    Task.all(:project_id => id)
  end

  def self.find_or_create(project_hash)
    first(:harvest_id => project_hash["id"]) ||
    create({
      :name        => project_hash["name"],
      :harvest_id  => project_hash["id"],
      :client_name => project_hash["client"]
    })
  end

  def to_s
    "#{client_name}: #{name}"
  end

end
