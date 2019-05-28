class CreateSends < ActiveRecord::Migration[5.1]
  def change
    create_table :sends do |t|
      t.string :superior
      t.datetime :month
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
