class AddFrecuenciaToControls < ActiveRecord::Migration
  def change
    add_column :controls, :frecuencia, :string
  end
end
