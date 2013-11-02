class ButtonSetter < Struct.new(:params)

  def self.set(params)
    new(params).set
  end

  def set
    params.each do |key, value|
      button = key[-1].to_i
      plant = Plant.first(:button => button) || Plant.create(:button => button)
      plant.update(:harvest_id => value)
    end
  end

end
