class InstructorsController < ApplicationController
	before_filter :authenticate_user!

	def welcome
  
	end

	def index
    @users=User.all
    if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.all.order('created_at DESC')
  end
  end
  
def show
    @user = User.find(params[:id])
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
