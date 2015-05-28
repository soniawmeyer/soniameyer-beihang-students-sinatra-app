require "rubygems"
require "google_drive"
require './credentials'
require "./student"
require "./grade"


class StudentSpreadsheet
  
  attr_accessor :worksheet
  
  def initialize
    credentials = Credentials.new
    session = GoogleDrive.login_with_oauth(credentials.access_token)
    @worksheet = session.spreadsheet_by_key("1LqJXjZ9oX4wkuzy2XUisdPMQ2ttlorfha1e8n5RZ1rM").worksheets[0]
  end

  def get_ss_with_ssnum (ssnum)
    
    ssrow = @worksheet.rows.detect do |row|
      row[1]==ssnum
    end
    
    if ssrow == nil
      return nil
    end
    
    grades = []
    
    for i in 4..12
      earned = ssrow[i]
      
      if earned != ''
        name = @worksheet[1,i+1]
        grades << Grade.new(name,earned)
      end
    end
    
    return Student.new(ssrow[0],ssrow[1],ssrow[2],ssrow[3],grades)
    
  end

end


# ss = StudentSpreadsheet.new
# student = ss.get_ss_with_ssnum("123456789")
# puts student.english_name
# puts student.chinese_name
# puts student.classnum
