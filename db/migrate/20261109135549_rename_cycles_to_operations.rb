class RenameCyclesToOperations < ActiveRecord::Migration[8.1]
  def change
    rename_table :cycles, :operations
    rename_column :logs, :cycle_id, :operation_id
  end
end
