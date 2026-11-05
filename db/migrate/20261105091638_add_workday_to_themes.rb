class AddWorkdayToThemes < ActiveRecord::Migration[8.1]
  def change
    add_column :themes, :workday, :boolean, default: true
  end
end
