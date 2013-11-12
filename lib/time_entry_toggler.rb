class TimeEntryToggler < Struct.new(:button, :user)

  def self.toggle(button, user)
    new(button, user).toggle
  end

  def self.toggle_timer(time_entry, user)
    new(-1, user).toggle_timer(time_entry)
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

  # returns true  if timer is on
  # returns false if timer is off
  def toggle_timer(time_entry)
    client.time.toggle(time_entry.harvest_id).timer_started_at.present?
  end

  private

  def plant
    @plant ||= Plant.first(:button => button, :user_id => user.id)
  end

  def client
    @client ||= user.client
  end

end
