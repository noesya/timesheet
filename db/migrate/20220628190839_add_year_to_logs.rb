class AddYearToLogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :logs, :year, null: false, foreign_key: true
  end
end
