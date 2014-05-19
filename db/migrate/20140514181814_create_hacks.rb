class CreateHacks < ActiveRecord::Migration
  def change
    create_table :hacks do |t|
      t.string :title
      t.integer :votes, :default => 0
      t.string :hack_url
      t.string :img_url
      t.string :owner
      t.text :description
      t.references :hackday

      t.timestamps
    end
    add_index :hacks, :hackday_id
  end
end
