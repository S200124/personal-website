class Appointment < ApplicationRecord

  before_save :check_recurring, if: :is_customer?
  before_save :check_not_recurring, if: :is_customer?

  def check_recurring
    Appointment.where(recurring: true).each do |app|
      throw :abort if overlap(app) and app.days_array.include? "#{self.event_date.wday}"
    end
  end

  def check_not_recurring
    throw :abort unless Appointment.where("id <> ? AND recurring = ? AND (end > ? AND start < ?)", (self.id || 0), false, self.start, self.end).empty?
  end

  def is_customer?
    (not recurring) and (not fixed) # I use "recurring" and "fixed" just because there are no users. Otherwise could be better.
  end

  def days_array
    JSON.parse(daysOfWeek || "[]")
  end

  def overlap(app)
    date_start = DateTime.parse("#{self.event_date}T#{app.startTime}+01:00").to_time.to_i * 1000
    date_end = DateTime.parse("#{self.event_date}T#{app.endTime}+01:00").to_time.to_i * 1000 # can be better with dedicated gems

    return ((self.start < date_end) and (date_start < self.end))
  end

  def event_date
    DateTime.strptime("#{self.start/1000}",'%s').to_date
  end

end
