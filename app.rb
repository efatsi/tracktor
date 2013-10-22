require 'bundler'
Bundler.setup(:default)
Bundler.require

load 'models/plant.rb'
load 'helpers/try.rb'

configure do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tracktor.db")
  DataMapper.finalize

  if Plant.count == 0
    client = Harvest.client('vigetlabs', ENV["HARVEST_EMAIL"], ENV["HARVEST_PASSWORD"])
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
  if plant = Plant.first(:button => params[:timer])
    client.time.toggle(plant.entry_id)
  end

  redirect "/"
end

def client
  @client ||= Harvest.client('vigetlabs', ENV["HARVEST_EMAIL"], ENV["HARVEST_PASSWORD"])
end
