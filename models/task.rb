class Task
  include DataMapper::Resource

  property :id, Serial
  property :name, Text
  property :harvest_id, Integer
  property :project_id, Integer

  validates_presence_of :name, :harvest_id, :project_id

  has n, :plants, :constraint => :destroy

  belongs_to :project

  def self.first_or_create(task_hash)
    first(:harvest_id => task_hash["id"], :project_id => task_hash["project_id"]) ||
    create({
      :name       => task_hash["name"],
      :harvest_id => task_hash["id"],
      :project_id => task_hash["project_id"]
    })
  end

end
