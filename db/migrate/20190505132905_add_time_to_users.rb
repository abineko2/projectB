class AddTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users,:affiliation,:string
    add_column :users,:employee_number,:integer
    add_column :users,:uid,:string
    add_column :users, :basic_work_time, :datetime, default:Time.zone.parse("2019/05/01 08:00")
    add_column :users, :designated_work_start_time, :datetime, default:Time.zone.parse("2019/05/01 08:00")
    add_column :users,:designated_work_end_time,:datetime,default:Time.zone.parse("2019/05/01 08:00")
    add_column :users,:superior,:boolean,default:false
    add_column :users, :admin, :boolean,default:false
   
    
    
   
    add_index :users,:email,unique:true
    
  end
end
