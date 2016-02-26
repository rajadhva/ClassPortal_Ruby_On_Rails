class Course < ActiveRecord::Base
  validates(:CourseNumber, presence: true, uniqueness: { case_sensitive: false },length: {minimum: 0,maximum: 13})
  validates(:Title, presence: true, uniqueness: { case_sensitive: false })
  validates(:Startdate, presence:true)
  validates(:Enddate, presence:true)
  has_many :requests, :dependent => :destroy
  has_many :references
  has_many :enrollments, :dependent => :destroy
  has_many :course_instructors, :dependent => :destroy
  accepts_nested_attributes_for :course_instructors, allow_destroy: true

  def self.search(query)
    where("Title like ? or CourseNumber like ?", "%#{query}%", "%#{query}%")
  end
  end
