class AddSuperiorTo < ActiveRecord::Migration[5.1]
  def change
    add_column :users,:superior,:boolean,default:false
    add_column :users,:appoin_end_time,:datetime
    add_column :users,:employee_number,:integer
    add_column :users,:uid,:string
  end
end
