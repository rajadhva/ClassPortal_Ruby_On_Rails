class InstructorsController < ApplicationController
	before_filter :authenticate_user!

	def welcome
  
	end

  def destroy
  Instructor.find(params[:id]).destroy
  
  flash[:success]="Instructor Removed"
  redirect_to request.referrer
  end

	def index
    @instructors=Instructor.all
    if params[:search]
    @instructors = Instructor.search(params[:search]).order("created_at DESC")
  else
    @instructors = Instructor.all.order('created_at DESC')
  end
  end
  
def show
    @instructor = Instructor.find(params[:id])
end

  def view
    @courseId=Course.where("Instructor=3").select("id")
    @temp=[]
    @courseId.each   do |x|
        @temp.append(x.id)
    end
    @showRecords=Request.where(:course_id => @temp, :Status=>'Pending')
    @request=Request.all
  end

end
