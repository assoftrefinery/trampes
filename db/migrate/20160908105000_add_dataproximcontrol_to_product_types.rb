class AddDataproximcontrolToProductTypes < ActiveRecord::Migration
  def change
    add_column :product_types, :dataproximcontrol, :datetime
  end
end
