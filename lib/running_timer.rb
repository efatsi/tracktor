class RunningTimer < Struct.new(:user)

  def self.find(user)
    new(user).find
  end

  def find
    if time_entry = TimeEntry.first(:harvest_id => running_timer_id)
      plant = time_entry.plant
      { :running => true, :button => plant.button }.to_json
    else
      { :running => false }.to_json
    end
  end

  private

  def running_timer_id
    client.time.all.detect(&:timer_started_at).try(:id)
  end

  def client
    user.client
  end
end
