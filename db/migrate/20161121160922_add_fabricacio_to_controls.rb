class AddFabricacioToControls < ActiveRecord::Migration
  def change
    add_column :controls, :fabricacio, :string
  end
end
