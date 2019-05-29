class AddConfToSends < ActiveRecord::Migration[5.1]
  def change
    add_column :sends, :conf, :string
    add_column :sends, :tm, :datetime
    add_column :sends, :box, :boolean
  end
end
