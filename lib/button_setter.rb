class ButtonSetter < Struct.new(:params)

  def self.set(params)
    new(params).set
  end

  def set
    params.each do |key, value|
      button = key[-1].to_i
      plant  = Plant.first_or_new(button)

      plant.task_id = value

      plant.save
    end
  end

end
