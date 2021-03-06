class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.string :sperior
      t.date :worked_on
      t.datetime :start_at
      t.datetime :finished_at
      t.datetime :new_start
      t.datetime :new_finish
      t.datetime :plans
      t.boolean :box
      t.string :note
      t.string :year
      t.string :month
      t.string :format_new_time
      t.string :format_finish_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
