class Enrollment < ActiveRecord::Base
	belongs_to :student
	belongs_to :course


	def self.search_by_student(query)
    where("student_id = ? ", "#{query}")
  	end
	
	def self.search_by_course(query)
    where("course_id = ? ", "#{query}")
  	end
end
