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

  def update_token
    token_results = HTTParty.post("https://api.harvestapp.com/oauth2/token", :body => {
      :refresh_token => harvest_refresh_token,
      :client_id     => ENV["HARVEST_CLIENT_ID"],
      :client_secret => ENV["HARVEST_CLIENT_SECRET"],
      :grant_type    => "refresh_token"
    })

    update(:harvest_access_token => token_results["access_token"], :harvest_refresh_token => token_results["refresh_token"])
  end

end
