class AddFotobaseToTrampas < ActiveRecord::Migration
  def change
    add_column :trampas, :fotobase, :string
  end
end
