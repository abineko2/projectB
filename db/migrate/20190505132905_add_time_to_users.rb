class AddTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :basic_time, :datetime, default:Time.zone.parse("2019/05/01 08:00")
    add_column :users, :appoint_time, :datetime, default:Time.zone.parse("2019/05/01 08:00")
    add_column :users, :admin, :boolean,default:false
    add_index :users,:email,unique:true
    
  end
end
