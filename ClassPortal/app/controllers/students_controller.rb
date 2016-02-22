class StudentsController < ApplicationController

	def index
    @students=Student.all
    if params[:search]
    @students = Student.search(params[:search]).order("created_at DESC")
  else
    @students = Student.all.order('created_at DESC')
  end
  end

  def show
    @student = Student.find(params[:id])
  end

  def destroy
  Student.find(params[:id]).destroy
  
  flash[:success]="Student Removed"
  redirect_to request.referrer
  end
  
def welcome
    @user = Student.find(current_user.id)
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
