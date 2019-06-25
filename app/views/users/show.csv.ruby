require 'csv'
require 'date'
require 'time'


CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  add_colum=%w(月日 出勤 退勤)
  
  csv <<add_colum
  dates=@user.attendances.where('worked_on>=? and worked_on<=?',@first_day,@last_day).order('worked_on asc')
  dates.each do |day|
     start=day.start_at.present? ? day.start_at : day.format_new_time
     finish=day.finished_at.present? ? day.finished_at : day.format_finish_time
     s=day.format_new_time
     f=day.format_finish_time
     add_value=[
        day.worked_on.to_s(:date),
        s,
        f,
     ]
     csv << add_value
  end
end