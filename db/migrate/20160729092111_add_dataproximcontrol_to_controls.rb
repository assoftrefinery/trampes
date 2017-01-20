class AddDataproximcontrolToControls < ActiveRecord::Migration
  def change
    add_column :controls, :dataproximcontrol, :datetime
  end
end
