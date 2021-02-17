class Address < ApplicationRecord

  has_many :jobs
  has_many :addresses_profiles
  has_many :profiles, through: :addresses_profiles

  def complete_address
    "#{street}, #{postal_code} #{city} (#{province}), #{country}"
  end
end
