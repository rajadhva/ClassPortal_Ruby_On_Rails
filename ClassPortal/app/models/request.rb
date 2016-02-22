class Request < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  validates_uniqueness_of :student_id, :scope=>[:course_id]

  def self.search_by_user_course(query1,query2)
    where("student_id = ? and course_id = ? ", "#{query1}", "#{query2}")
  end

end
