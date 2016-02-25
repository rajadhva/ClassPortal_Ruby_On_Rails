class CourseInstructor < ActiveRecord::Base
  belongs_to :course
  belongs_to :instructor

  def self.search_by_instructor(query)
    where("instructor_id = ? ", "#{query}")
  end
end
