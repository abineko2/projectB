class AddTimeToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :first_day, :datetime
    add_column :attendances, :result, :string,default:""
    add_column :attendances, :center_s, :datetime
    add_column :attendances, :center_f, :datetime
    add_column :attendances, :time, :string
    add_column :attendances, :overtime, :string
    add_column :attendances, :box2, :boolean,default:false
    add_column :attendances, :box3, :boolean,default:false
    add_column :attendances, :note2, :string
    add_column :attendances, :answer,:string,default:nil
    add_column :attendances, :sperior2 , :string
    add_column :attendances, :new_finish2, :datetime
    add_column :attendances, :atted_count, :integer,default:0
  end
end
