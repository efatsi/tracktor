require 'bundler'
Bundler.setup(:default)
Bundler.require

require 'json'
require 'cgi'
require 'sinatra/cookies'
require 'active_support/core_ext/time/zones'
require 'active_support/core_ext/date/calculations'

Dir["models/*.rb"].each  {|file| load file }
Dir["helpers/*.rb"].each {|file| load file }
Dir["lib/*.rb"].each     {|file| load file }

include CurrentUserHelper
include UrlHelper

enable :sessions

configure do
  DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_GRAY_URL'])
  DataMapper.finalize

  Time.zone = "MST"
end

get "/" do
  if logged_in?
    redirect "/home"
  else
    erb :login
  end
end

get "/logout" do
  response.set_cookie 'user_token', nil
  redirect "/"
end

get "/home" do
  require_login

  reset_cookie(current_user)

  SetterUpper.set_it_up!(current_user)
  erb :home
end

post "/set" do
  require_login

  PlantSetter.set(params, current_user)
  redirect "/home"
end

get "/toggle" do
  content_type :json

  if token_user.present?
    TimeEntryToggler.toggle(params[:button], token_user)
  else
    { :invalid_user => true }.to_json
  end
end

get "/running_timer" do
  content_type :json

  if token_user.present?
    RunningTimer.find(token_user)
  else
    { :invalid_user => true }.to_json
  end
end


# OAuth2 Authentication
get "/auth" do
  code = params[:code]

  token_results = HTTParty.post("https://api.harvestapp.com/oauth2/token", :body => {
    :code          => code,
    :client_id     => ENV["HARVEST_CLIENT_ID"],
    :client_secret => ENV["HARVEST_CLIENT_SECRET"],
    :redirect_uri  => ENV["HARVEST_REDIRECT_URI"],
    :grant_type    => "authorization_code"
  })

  token_params = {
    :harvest_access_token  => token_results["access_token"],
    :harvest_refresh_token => token_results["refresh_token"]
  }

  if logged_in?
    current_user.update(token_params)
    reset_cookie(current_user)
  else
    user = User.create(token_params)
    reset_cookie(user)
  end

  redirect "/home"
end
