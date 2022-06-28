class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :week, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.integer :days, default: 0

      t.timestamps
    end
  end
end
