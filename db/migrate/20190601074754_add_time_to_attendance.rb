class AddTimeToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :first_day, :datetime
    add_column :attendances, :result, :string,default: ""
    add_column :attendances, :center_s, :datetime
    add_column :attendances, :center_f, :datetime
  end
end
