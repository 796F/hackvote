class AddDescToHack < ActiveRecord::Migration
  def change
    add_column :hacks, :description, :text
  end
end
