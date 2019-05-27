class CreateSends < ActiveRecord::Migration[5.1]
  def change
    create_table :sends do |t|
      t.string :superior
      t.datetime :month
      t.string :user
      t.string :conf

      t.timestamps
    end
  end
end
