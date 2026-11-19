class AddCycleToLogs < ActiveRecord::Migration[8.1]
  def change
    add_reference :logs, :cycle, null: true, foreign_key: true
  end
end
