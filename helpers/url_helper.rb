module UrlHelper

  def oauth_url
    "https://api.harvestapp.com/oauth2/authorize?client_id=#{ENV["HARVEST_CLIENT_ID"]}&redirect_uri=#{ENV["HARVEST_REDIRECT_URI"]}&response_type=code"
  end

end
