class Attendance < ApplicationRecord
  belongs_to :user
  validates :worked_on,presence:true
  validate :check_start_at
  validate :comparison
  
  
  def check_start_at
    if self.start_at.nil?
      errors.add(:finished_at,"出勤がされてません")
    end  
  end 
  
  def comparison
    if self.start_at > self.finished_at
      errors.add(:finished_at,"出勤時間が退勤時間より後になってます")
    end  
  end
end
