class User
  include DataMapper::Resource

  property :id, Serial
  property :token, String
  property :domain, String
  property :email, String
  property :password, String

  validates_presence_of :domain, :email, :password
end
