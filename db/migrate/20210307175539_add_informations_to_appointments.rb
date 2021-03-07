class AddInformationsToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :title, :string
    add_column :appointments, :start, :integer
    add_column :appointments, :end, :integer
    add_column :appointments, :allDay, :boolean
    add_column :appointments, :backgroundColor, :string
    add_column :appointments, :borderColor, :string
  end
end
