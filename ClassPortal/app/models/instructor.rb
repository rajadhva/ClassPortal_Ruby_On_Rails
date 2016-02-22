class Instructor < User
has_many :course_instructors, :dependent => :destroy
end
