require 'bundler'
Bundler.setup(:default)
Bundler.require

require 'json'
require 'sinatra/cookies'

Dir["models/*.rb"].each  {|file| load file }
Dir["helpers/*.rb"].each {|file| load file }
Dir["lib/*.rb"].each     {|file| load file }

include CurrentUserHelper

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

post "/login" do
  if user = User.first_or_create(params)
    session[:user_token] = user.token

    if params[:remember]
      response.set_cookie 'user_token', {
        :value   => user.token,
        :max_age => "15552000" # 6 months
      }
    end

    redirect "/home"
  else
    redirect "/"
  end
end

get "/logout" do
  session[:user_token] = nil
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
    TimeEntryToggler.toggle(params[:button], current_user)
  else
    { :invalid_user => true }.to_json
  end
end

get "/running_timer" do
  content_type :json

  if token_user.present?
    RunningTimer.find(current_user)
  else
    { :invalid_user => true }.to_json
  end

end
