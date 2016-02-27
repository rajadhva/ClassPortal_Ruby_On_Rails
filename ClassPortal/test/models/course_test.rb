require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Course entry should be valid" do
    course = Course.new(:Title => "TestCourse", :Description=> "testing course", :Status => 0, :CourseNumber=>"CSCTest")
    assert course.save
  end

  test "validation checks for books" do

  #title is null
  test "Title should not be null" do
    course = Course.new(:Description=> "testing course", :Status => 0, :CourseNumber=>"CSCTest" )
    assert_not user.valid?
  end

  #Course number is null
  test "Course Number should not be null" do
    course = Course.new(:Title => "TestCourse",:Description=> "testing course", :Status => 0)
    assert_not user.valid?
  end

  end
  #Cannot have duplicate Course Numbers
  test "Cannot have duplicate CourseNumbers" do
  course1 = Course.new(:Title => "TestCourse 1", :Description=> "testing course 1", :Status => 0, :CourseNumber=>"CSCTest" )
  assert course1.save

  course2 = Course.new(:Title => "TestCourse 2", :Description=> "testing course 2", :Status => 0, :CourseNumber=>"CSCTest")
  assert course2.save
  end
end
