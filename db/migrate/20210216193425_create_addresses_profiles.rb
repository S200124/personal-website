class CreateAddressesProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses_profiles, :from, :timestamp
    add_column :addresses_profiles, :to, :timestamp
  end
end
