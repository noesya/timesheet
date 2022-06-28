class AddColorToTheme < ActiveRecord::Migration[7.0]
  def change
    add_column :themes, :color, :string
  end
end
