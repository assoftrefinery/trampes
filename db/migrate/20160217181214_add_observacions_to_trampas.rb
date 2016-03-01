class AddObservacionsToTrampas < ActiveRecord::Migration
  def change
    add_column :trampas, :observacions, :text
  end
end
