class AddRecurringInformationsToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :daysOfWeek, :string
    add_column :appointments, :startTime, :string
    add_column :appointments, :endTime, :string
    add_column :appointments, :fixed, :boolean, default: false
  end
end
