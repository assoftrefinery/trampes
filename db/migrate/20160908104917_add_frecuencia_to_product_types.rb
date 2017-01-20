class AddFrecuenciaToProductTypes < ActiveRecord::Migration
  def change
    add_column :product_types, :frecuencia, :string
  end
end
