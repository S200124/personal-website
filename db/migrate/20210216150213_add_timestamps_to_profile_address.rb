class AddTimestampsToProfileAddress < ActiveRecord::Migration[6.0]
  def change
    add_timestamps(:addresses_profiles)
  end
end
