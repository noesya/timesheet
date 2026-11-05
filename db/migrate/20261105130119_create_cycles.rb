class CreateCycles < ActiveRecord::Migration[8.1]
  def change
    create_table :cycles do |t|
      t.string :name
      t.string :code
      t.date :started_at
      t.date :ended_at
      t.text :description

      t.timestamps
    end
  end
end
