class TimeEntryToggler < Struct.new(:button)

  def self.toggle(button)
    new(button).toggle
  end

  def toggle
    if plant && time_entry = plant.existing_time_entry
      { :success => true, :on => toggle_timer(time_entry) }.to_json
    elsif plant && plant.new_time_entry
      { :success => true, :on => true }.to_json
    else
      { :success => false }.to_json
    end
  end

  private

  def plant
    @plant ||= Plant.first(:button => button)
  end

  # returns true  if timer is on
  # returns false if timer is off
  def toggle_timer(time_entry)
    client.time.toggle(time_entry.harvest_id).timer_started_at.present?
  end
end
