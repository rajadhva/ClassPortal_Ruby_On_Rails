class Student < User
	has_many :requests, :dependent => :destroy
	has_many :enrollments, :dependent => :destroy
  
end
