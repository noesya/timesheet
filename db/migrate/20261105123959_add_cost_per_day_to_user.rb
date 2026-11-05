class AddCostPerDayToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :cost_per_day, :integer, default: 0
  end
end
