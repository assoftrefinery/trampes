class CreateTrampas < ActiveRecord::Migration
  def change
    create_table :trampas do |t|
      t.string :nom
      t.string :tipus
      t.integer :recompte
      t.boolean :estat_ok
      t.references :audit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
