class RunningTimer

  def self.find
    new.find
  end

  def find
    if plant = Plant.first(:harvest_id => running_timer_id)
      { :running => true, :button => plant.button }.to_json
    else
      { :running => false }.to_json
    end
  end

  private

  def running_timer_id
    client.time.all.detect(&:timer_started_at).try(:id)
  end

end
