require 'bundler'
Bundler.setup(:default)
Bundler.require

require 'json'

Dir["models/*.rb"].each  {|file| load file }
Dir["helpers/*.rb"].each {|file| load file }
Dir["lib/*.rb"].each     {|file| load file }

include Client
include CurrentUserHelper

enable :sessions

configure do
  DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_GRAY_URL'])
  DataMapper.finalize

  Initializer.set_it_up!
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
    redirect "/home"
  else
    redirect "/"
  end
end

get "/logout" do
  session[:user_token] = nil
  redirect "/"
end

get "/home" do
  if logged_in?
    @client = client
    erb :settings
  else
    redirect "/"
  end
end

post "/set" do
  ButtonSetter.set(params)

  redirect "/home"
end

get "/toggle" do
  content_type :json

  TimeEntryToggler.toggle(params[:button])
end

get "/running_timer" do
  content_type :json

  RunningTimer.find
end
