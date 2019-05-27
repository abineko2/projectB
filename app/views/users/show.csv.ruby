require 'csv'
require 'date'


CSV.generate do |csv|
  add_colum=%w(月日 出勤 退勤)
  csv <<add_colum
  dates=@user.attendances.where('worked_on>=? and worked_on<=?',@first_day,@last_day).order('worked_on asc')
  dates.each do |day|
     add_value=[
        day.worked_on.to_s(:date),
        day.start_at,
        day.finished_at,
     ]
     csv << add_value
  end
end