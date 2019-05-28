class AddConfToSends < ActiveRecord::Migration[5.1]
  def change
    add_column :sends, :conf, :string
  end
end
