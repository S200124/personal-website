class Appointment < ApplicationRecord

  before_save :check_calendar, if: :is_customer?

  def check_calendar
    date = DateTime.strptime("#{self.start/1000}",'%s').to_date

    Appointment.where("id <> ?", (self.id || 0)).each do |app|
      throw :abort if (self.date_start() < app.date_end(date)) and (app.date_start(date) < self.date_end())
    end
  end

  def is_customer?
    (not recurring) and (not fixed) # I use "recurring" and "fixed" just because there are no users. Otherwise could be better.
  end

  def date_start(date = nil)
    if recurring
      DateTime.parse("#{date}T#{startTime}+01:00").to_time.to_i * 1000
    else
      self.start
    end
  end

  def date_end(date = nil)
    if recurring
      DateTime.parse("#{date}T#{endTime}+01:00").to_time.to_i * 1000
    else
      self.end
    end
  end
end
