class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.string :basename
      t.integer :baseno
      t.string :attend

      t.timestamps
    end
  end
end
