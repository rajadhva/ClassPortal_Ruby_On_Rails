class Instructor < User
has_many :course_instructors, :dependent => :destroy
has_many :inactive_requests, :dependent => :destroy
end
