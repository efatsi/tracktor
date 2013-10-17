
require 'bundler'
Bundler.setup(:default)
Bundler.require

get "/" do
  erb :index
end

# require 'harvested'
# require 'sinatra'

# harvest = Harvest.client('vigetlabs', 'eli.fatsi@viget.com', 'Smelisas-0')

# id = harvest.time.all.map(&:id).first
# harvest.time.toggle(id)
