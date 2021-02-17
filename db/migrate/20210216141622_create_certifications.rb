class CreateCertifications < ActiveRecord::Migration[6.0]
  def change
    create_table :certifications do |t|
      t.string :institute
      t.string :type
      t.string :name
      t.timestamp :from
      t.timestamp :to

      t.belongs_to :profile

      t.timestamps
    end
  end
end
