class CreateAuditvs < ActiveRecord::Migration
  def change
    create_table :auditvs do |t|
      t.date :dataaudit
      t.text :observacions

      t.timestamps null: false
    end
  end
end
