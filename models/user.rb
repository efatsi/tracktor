class User
  include DataMapper::Resource

  property :id, Serial
  property :token, String
  property :harvest_access_token, Text
  property :harvest_refresh_token, Text

  before :create, :generate_token

  has n, :projects
  has n, :plants

  def generate_token
    self.token = SecureRandom.urlsafe_base64(5)
  end

  def client
    Harvest.client(:access_token => harvest_access_token)
  end

end
