class CreateControls < ActiveRecord::Migration
  def change
    create_table :controls do |t|
      t.string :nom
      t.datetime :datacontrol
      t.string :operari

      t.timestamps null: false
    end
  end
end
