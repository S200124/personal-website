class AddRecurringFlagToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :recurring, :boolean, default: false
  end
end
