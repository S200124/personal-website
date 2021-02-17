class Profile < ApplicationRecord

  has_many :jobs
  has_many :certifications
  has_many :addresses_profiles
  has_many :addresses, through: :addresses_profiles

  def full_name
    "#{name} #{surname}"
  end
end
