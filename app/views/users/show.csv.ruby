require 'csv'
require 'date'


CSV.generate do |csv|
  add_colum=%w(月日 出勤 退勤)
  
  csv <<add_colum
  dates=@user.attendances.where('worked_on>=? and worked_on<=?',@first_day,@last_day).order('worked_on asc')
  dates.each do |day|
     start=day.start_at.present? ? day.start_at : day.new_start
     finish=day.finished_at.present? ? day.finished_at : day.new_finish
     add_value=[
        day.worked_on.to_s(:date),
        start,
        finish,
     ]
     csv << add_value
  end
end