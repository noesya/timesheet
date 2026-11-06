class AddWithResearchToThemes < ActiveRecord::Migration[8.1]
  def change
    add_column :themes, :with_research, :boolean, default: false
  end
end
