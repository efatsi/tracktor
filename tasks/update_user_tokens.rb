require 'data_mapper'
require 'dm-postgres-adapter'
require 'httparty'

Dir["models/*.rb"].each  {|file| load file }

DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_GRAY_URL'])
DataMapper.finalize

User.all.each do |user|
  user.update_token
end
