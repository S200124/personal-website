class CreateJoinTableProfileAddress < ActiveRecord::Migration[6.0]
  def change
    create_join_table :profiles, :addresses do |t|
      t.index :profile_id
      t.index :address_id
    end
  end
end
