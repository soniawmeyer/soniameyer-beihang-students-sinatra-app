require 'sinatra'
require 'kramdown'
require_relative 'student_spreadsheet'
require "google_drive"



post '/students' do
  
  credentials = Credentials.new
  session = GoogleDrive.login(credentials.email, credentials.password)

  ws = session.spreadsheet_by_key("1dQDdmBeoWZhko29KNuKQHh2SddnXo-zILoukIG4KjgE").worksheets[0]

  n = ws.rows.size+1

  ws[n,1] = Time.now.to_s
  ws[n,2] = params[:class_num]
  ws[n,3] = params[:ssnum]
  ws[n,4] = params[:chinese_name]
  ws[n,5] = params[:english_name]
  ws[n,6] = params[:email]

  ws.save()
  
  return "Thank you for submitting. To return to the homepage, click <a href='http://sonia.meyercraft.net'>here</a>"
  
end




post '/grades' do
  redirect to("/grades/#{params[:ssnum]}")
end

get '/grades/:ssnum' do |ssnum|
  ss = StudentSpreadsheet.new
  student = ss.get_ss_with_ssnum(ssnum)
  
  if student == nil
    return "Sorry, something went wrong. Did you enter your student number correctly?"
  end
  
  table = "|#{student.grades.map(&:name).join("|")}|\n" +
          "#{"|:-:" * student.grades.count}|\n" +
          "|#{student.grades.map(&:earned).join("|")}|"
          
  erb :grades, :locals => { :student_name => student.english_name,
                            :table        => markdown(table)}
end
