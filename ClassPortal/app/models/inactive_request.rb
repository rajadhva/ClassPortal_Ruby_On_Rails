class InactiveRequest < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :course
  validates_uniqueness_of :instructor_id, :scope=>[:course_id]

  def self.search_by_user_course(query1,query2)
    where("instructor_id = ? and course_id = ? ", "#{query1}", "#{query2}")
  end
end
