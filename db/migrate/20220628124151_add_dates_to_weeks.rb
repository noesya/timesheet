class AddDatesToWeeks < ActiveRecord::Migration[7.0]
  def change
    add_column :weeks, :starting_at, :date
    add_column :weeks, :ending_at, :date
  end
end
