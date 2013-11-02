require 'bundler'
Bundler.setup(:default)
Bundler.require

require 'json'

Dir["models/*.rb"].each  {|file| load file }
Dir["helpers/*.rb"].each {|file| load file }
Dir["lib/*.rb"].each     {|file| load file }

include Client

configure do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tracktor.db")
  DataMapper.finalize

  Initializer.set_it_up!
end

get "/" do
  erb :index
end

get "/settings" do
  @client = client
  erb :settings
end

post "/set" do
  ButtonSetter.set(params)

  redirect "/"
end

get "/toggle" do
  content_type :json

  TimeEntryToggler.toggle(params[:button])
end

get "/running_timer" do
  content_type :json

  RunningTimer.find
end
