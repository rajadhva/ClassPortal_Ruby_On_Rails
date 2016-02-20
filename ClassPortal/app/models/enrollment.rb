class Enrollment < ActiveRecord::Base
	belongs_to :user
	belongs_to :course


	def self.search_by_student(query)
    where("user_id = ? ", "#{query}")
  	end

end
