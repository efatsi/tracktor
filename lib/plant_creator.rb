class PlantCreator

  def self.create
    new.create
  end

  def create
    (1..6).each do |button|
      Plant.create(:button => button)
    end
  end

end
