class AddDescripcioToTrampas < ActiveRecord::Migration
  def change
    add_column :trampas, :descripcio, :text
  end
end
