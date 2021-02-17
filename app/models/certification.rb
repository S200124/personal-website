class Certification < ApplicationRecord

  belongs_to :profile

  def course_name
    "#{level} - #{name}"
  end
end
