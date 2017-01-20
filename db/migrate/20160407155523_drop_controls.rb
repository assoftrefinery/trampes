class DropControls < ActiveRecord::Migration
  def change
    drop_table :controls
  end
end
