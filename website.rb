require 'sinatra'
require 'kramdown'
require './student_spreadsheet'

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
