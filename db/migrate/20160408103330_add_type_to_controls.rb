class AddTypeToControls < ActiveRecord::Migration
  def change
    add_column :controls, :product_type_id, :integer
    add_column :controls, :properties, :text
  end
end
