class AddProfileToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :profile_id, :integer
    add_foreign_key :jobs, :profiles
  end
end
