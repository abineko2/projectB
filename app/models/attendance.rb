class Attendance < ApplicationRecord
  belongs_to :user
  validates :attendance,presence:true
end
