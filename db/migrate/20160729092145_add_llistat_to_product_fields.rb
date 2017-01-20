class AddLlistatToProductFields < ActiveRecord::Migration
  def change
    add_column :product_fields, :llistat, :boolean
  end
end
