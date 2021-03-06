class CreateSend2s < ActiveRecord::Migration[5.1]
  def change
    create_table :send2s do |t|
      t.string :sperior
      t.date :worked_on
      t.string:time
      t.string :overtime
      t.datetime :new_finish
      t.boolean :box,default:false
      t.string :note
      t.string :answer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
