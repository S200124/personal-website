class Appointment < ApplicationRecord

  before_save :check_recurring, if: :is_customer?
  before_save :check_not_recurring, if: :is_customer?

  scope :recurring, -> { where(recurring: true) }
  scope :not_recurring, -> { where(recurring: false) }
  scope :id_not_equal, -> (id) { where('id <> ?', id) }
  scope :operlap, -> (s, e) { where('end > ? AND start < ?', s, e) }

  def check_recurring
    Appointment.recurring.each do |app|
      throw :abort if overlaps?(app)
    end
  end

  def check_not_recurring
    throw :abort unless Appointment.not_recurring.id_not_equal(id || 0).operlap(self.start, self.end).empty?
  end

  def is_customer?
    (not recurring) and (not fixed) # I use "recurring" and "fixed" just because there are no users. Otherwise could be better.
  end

  def days_array
    JSON.parse(daysOfWeek || "[]")
  end

  def overlaps?(app)
    if app.recurring
      date_start = DateTime.parse("#{self.start_date}T#{app.startTime}+01:00").to_time.to_i * 1000 # conversion to UNIX epoch can be better probably
      date_end = DateTime.parse("#{self.end_date}T#{app.endTime}+01:00").to_time.to_i * 1000
      valid_days_array = (app.days_array & ["#{self.start_date.wday}", "#{self.end_date.wday}"]).any?
    else
      date_start = app.start
      date_end = app.end
      valid_days_array = true
    end

    return (((self.start < date_end) and (date_start < self.end)) and valid_days_array)
  end

  def start_date
    DateTime.strptime("#{self.start/1000}",'%s').to_date
  end

  def end_date
    DateTime.strptime("#{self.end/1000}",'%s').to_date
  end

end
