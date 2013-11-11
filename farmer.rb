require 'bundler'
Bundler.setup(:default)
Bundler.require

require 'json'
require 'sinatra/cookies'

Dir["models/*.rb"].each  {|file| load file }
Dir["helpers/*.rb"].each {|file| load file }
Dir["lib/*.rb"].each     {|file| load file }

include CurrentUserHelper
include UrlHelper

enable :sessions

configure do
  DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_GRAY_URL'])
  DataMapper.finalize
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

  SetterUpper.set_it_up!(current_user)
  erb :settings
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

  result = HTTParty.post("https://api.harvestapp.com/oauth2/token", :body => {
    :code          => code,
    :client_id     => ENV["HARVEST_CLIENT_ID"],
    :client_secret => ENV["HARVEST_CLIENT_SECRET"],
    :redirect_uri  => ENV["HARVEST_REDIRECT_URI"],
    :grant_type    => "authorization_code"
    })

  user = User.create(:harvest_access_token => @result["access_token"], :harvest_refresh_token => @result["refresh_token"])

  response.set_cookie 'user_token', {
    :value   => user.token,
    :max_age => "31104000" # 6 months
  }

  redirect "/home"
end
