class PlantSetter < Struct.new(:params, :user)

  def self.set(params, user)
    new(params, user).set
  end

  def set
    params.each do |key, value|
      button = key[-1].to_i
      plant  = Plant.first_or_new(:button => button, :user => user)

      plant.task_id = value

      plant.save
    end
  end

end
