class HistoryController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.student
      @enrollments = Enrollment.search_by_student(@user.id)
    elsif @user.instructor
      @enrollments = CourseInstructor.search_by_instructor(@user.id)
    end
  end
end
