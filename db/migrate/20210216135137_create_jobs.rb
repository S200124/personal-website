class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :task
      t.string :company
      t.string :time
      t.timestamp :from
      t.timestamp :to
      t.text :description

      t.belongs_to :address

      t.timestamps
    end
  end
end
