class CreateHackdays < ActiveRecord::Migration
  def change
    create_table :hackdays do |t|
      t.string :title
      t.date :day
      t.string :img_url

      t.timestamps
    end
  end
end
