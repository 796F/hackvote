class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.references :hack

      t.timestamps
    end
    add_index :owners, :hack_id
  end
end
