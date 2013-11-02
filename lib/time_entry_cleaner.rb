class TimeEntryCleaner

  def self.clean
    new.clean
  end

  def clean
    old_time_entries.each(&:destroy)
  end

  private

  def old_time_entries
    TimeEntry.all.select{|p| p.date < Date.today}
  end

end
