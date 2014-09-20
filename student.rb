require_relative "grade"

class Student
  
  attr_accessor :classnum, :ssnum, :chinese_name, :english_name, :grades
  
  def initialize(classnum,ssnum,chinese_name,english_name,grades)
    @classnum = classnum
    @ssnum = ssnum
    @chinese_name = chinese_name
    @english_name = english_name
    @grades = grades
  end
  
end
