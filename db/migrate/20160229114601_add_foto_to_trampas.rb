class AddFotoToTrampas < ActiveRecord::Migration
  def change
    add_column :trampas, :foto, :string
  end
end
