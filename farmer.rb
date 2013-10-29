require 'bundler'
Bundler.setup(:default)
Bundler.require

require 'json'

load 'models/plant.rb'
load 'helpers/nil_helper.rb'

configure do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tracktor.db")
  DataMapper.finalize

  if Plant.count == 0
    client = Harvest.client(ENV["HARVEST_DOMAIN"], ENV["HARVEST_EMAIL"], ENV["HARVEST_PASSWORD"])
    client.time.all.map(&:id).each_with_index do |entry_id, index|
      Plant.create(:button => index + 1, :entry_id => entry_id)
    end
  end
end

get "/" do
  erb :index
end

get "/settings" do
  @client = client
  erb :settings
end

post "/set" do
  params.each do |key, value|
    button = key[-1].to_i
    plant = Plant.first(:button => button) || Plant.create(:button => button)
    plant.update(:entry_id => value)
  end

  redirect "/"
end

get "/toggle" do
  content_type :json

  if plant = Plant.first(:button => params[:timer])
    timer = client.time.toggle(plant.entry_id)
    { :success => true, :on => timer.timer_started_at.present? }.to_json
  else
    { :success => false }.to_json
  end
end

get "/running_timer" do
  content_type :json

  if plant = Plant.first(:entry_id => running_timer_id)
    { :running => true, :button => plant.button }.to_json
  else
    { :running => false }.to_json
  end
end

def running_timer_id
  client.time.all.select(&:timer_started_at).first.try(:id)
end

def client
  @client ||= Harvest.client(ENV["HARVEST_DOMAIN"], ENV["HARVEST_EMAIL"], ENV["HARVEST_PASSWORD"])
end
