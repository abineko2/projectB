class CreateNotices < ActiveRecord::Migration[5.1]
  def change
    create_table :notices do |t|
      t.integer :one_month_num,default:0
      t.integer :edit_num,default:0
      t.integer :over_time_num,default:0
      t.integer :user_id

      t.timestamps
    end
  end
end
