class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.date :dataaudit
      t.text :observacions

      t.timestamps null: false
    end
  end
end
