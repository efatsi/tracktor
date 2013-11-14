class Project
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :harvest_id, Integer
  property :client_name, String
  property :user_id, Integer

  validates_presence_of :name, :harvest_id, :client_name

  has n, :tasks, :constraint => :destroy
  belongs_to :user

  def self.first_or_create(project_hash, user)
    first(:harvest_id => project_hash["id"], :user_id => user.id) ||
    create({
      :name        => project_hash["name"],
      :harvest_id  => project_hash["id"],
      :client_name => project_hash["client"],
      :user_id     => user.id
    })
  end

  def to_s
    "#{client_name}: #{name}"
  end

end
