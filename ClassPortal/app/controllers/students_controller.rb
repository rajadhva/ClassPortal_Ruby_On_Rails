class StudentsController < ApplicationController

	def index
    @users=User.all
    if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.all.order('created_at DESC')
  end
  end

  def show
  end
  
def welcome
    @user = User.find(current_user.id)
    @enrollments = Enrollment.search_by_student(@user.id)
    @pastCourses = []
    @currentCourses = []
    @futureCourses = []
   
    @enrollments.each do |e| 
      course = Course.find(e.course_id)
         if course.Startdate > Date.today
        @futureCourses << course
      elsif course.Startdate < Date.today and course.Enddate > Date.today
        @currentCourses << course
      elsif course.Startdate < Date.today and course.Enddate < Date.today
        @pastCourses << course
      end
            
    end
  end 
end
