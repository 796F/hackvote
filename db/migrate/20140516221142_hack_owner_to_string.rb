class HackOwnerToString < ActiveRecord::Migration
  def up
    add_column :hacks, :owner, :string
  end

  def down
    remove_column :hacks, :owner
  end
end
