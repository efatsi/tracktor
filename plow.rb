require 'bundler'
Bundler.setup(:default)
Bundler.require

configure do
  # DataMapper.setup(:default)
  # DataMapper.finalize
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
    plant = Plant.where(:button => key[-1].to_i)
    plant.update_attributes(:entry_id => value)
  end
end

get "/submit" do
  client.time.toggle(params[:timer])
end

def client
  @client ||= Harvest.client('vigetlabs', 'eli.fatsi@viget.com', 'Smelisas-0')
end
# require 'harvested'
# require 'sinatra'

# harvest = Harvest.client('vigetlabs', 'eli.fatsi@viget.com', 'Smelisas-0')

# id = harvest.time.all.map(&:id).first
# harvest.time.toggle(id)
