class AddUbicacioToTrampas < ActiveRecord::Migration
  def change
    add_column :trampas, :ubicacio, :string
  end
end
