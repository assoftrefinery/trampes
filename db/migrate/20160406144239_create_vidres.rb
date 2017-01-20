class CreateVidres < ActiveRecord::Migration
  def change
    create_table :vidres do |t|
      t.string :nom
      t.string :tipus
      t.string :ubicacio
      t.text :descripcio
      t.string :fotobase
      t.integer :recompte
      t.boolean :estat_ok
      t.text :observacions
      t.string :foto
      t.references :auditv, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
