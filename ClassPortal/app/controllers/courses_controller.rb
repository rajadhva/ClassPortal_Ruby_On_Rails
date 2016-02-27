class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if current_user.instructor
      @courseInstructor = CourseInstructor.where(:instructor_id=>current_user.id)
      @courses = []
      @courseInstructor.each do |c|
        @courses << Course.find(c.course_id)
      end
    else
      @courses = Course.all
    end

    @courses.each do |course|
      if course.Enddate < Date.today
        @course = course
        @course.update(Status: "Inactive")
      end
    end
  end
 
  # GET /courses/1
  # GET /courses/1.json
  def show
    @course=Course.find(params[:id])
    @enrollment= Enrollment.find_by(:course_id=>@course.id, :student_id => current_user.id)
    @instructors = CourseInstructor.where(:course_id=>@course.id)
    puts @instructors.inspect
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @course=Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    if @course.save 
      @courseInstructor = CourseInstructor.new
      @courseInstructor.instructor_id = params[:course_instructors][:Instructor]
      @courseInstructor.course_id = @course.id
      @courseInstructor.save
      
      flash[:success] = "The course is added successfully!"
      redirect_to courses_url
    else
      render 'new'
    end

  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update

    #to send mail for subscriptions
    if (params[:Status]=="Active")
      @subscribe_list = Subscribe.where(:course => params[:Title])
      @subscribe_list.each do |i|
        SubscribeMailer.sample_email(i.user,i.course).deliver_now
        i.destroy
      end
    end

    @course_instructors = CourseInstructor.find_by(:course_id => @course.id)
 
    if @course_instructors.nil?
        course_instructor = CourseInstructor.new
        course_instructor.course_id = @course.id
        course_instructor.instructor_id = params[:course_instructors][:Instructor]
        course_instructor.save
    else 
        @course_instructors.update_attribute(:instructor_id,params[:course_instructors][:Instructor])
    end


    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def search
    @courses=Course.all

    if params[:CourseNumber].to_s != ''
      @courses = @courses.where("CourseNumber like ?", '%'+params[:CourseNumber].to_s+'%')
    end
    if params[:Title].to_s != ''
      @courses = @courses.where("Title like ?", '%'+params[:Title].to_s+'%')
    end

    if params[:Description].to_s != ''
      @courses = @courses.where("Description like ?", '%'+params[:Description].to_s+'%')
    end
    if params[:Status].to_s != ''
      @courses = @courses.where("Status like ?", '%'+params[:Status].to_s+'%')
      print 'after status check'
      puts @courses.size
      #@courses = @courses.find_(params[:Status].to_s)
    end

    if params[:Instructor].to_s != ''
      instructor = User.find_by_name(params[:Instructor].to_s)
      print 'Instructor ID = '
      puts instructor.id
      course_instructor = CourseInstructor.where("instructor_id = ?", instructor.id)
      print 'Course_Instructor size = '
      puts course_instructor.size
      list_of_courses = []
      course_instructor.each do |course|
        c = @courses.where('Title = ?', Course.find(course.course_id).Title.to_s)
        #course_name = Course.where(course.course_id)
        #if !course.nil?
       # print 'Course Name = '
       # puts course_name.Title
        #c = @courses.where("Title = ?", course_name.Title.to_s)
        if !c.nil? & (c.size > 0)
          #list_of_courses << c
          c.each do |a|
          puts a.CourseNumber
            list_of_courses << a
            end
        end
       # puts course.course_id
        end

      @courses = list_of_courses
    end

    #@courses = @courses.order('created_at DESC')
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:CourseNumber,:Title, :Description, :Instructor, :Startdate, :Enddate, :Status, course_instructors_attributes:[:course_id,:instructor_id])
  end
end