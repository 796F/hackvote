class CreateHackdays < ActiveRecord::Migration
  def change
    create_table :hackdays do |t|
      t.string :title, :null => false
      t.date :day
      t.string :img_url

      t.timestamps
    end
  end
end
