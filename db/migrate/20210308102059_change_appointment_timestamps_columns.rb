class ChangeAppointmentTimestampsColumns < ActiveRecord::Migration[6.0]
  def change
    change_column :appointments, :start, :bigint
    change_column :appointments, :end, :bigint
  end
end
