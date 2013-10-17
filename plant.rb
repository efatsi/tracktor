class Plant
  include DataMapper::Resource

  property :id, Serial
  property :button, Integer
  property :entry_id, Integer
end
