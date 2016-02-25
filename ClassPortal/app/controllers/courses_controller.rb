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
      @courses = @courses.where("CourseNumber = ?", params[:CourseNumber].to_s)
    end
    if params[:Title].to_s != ''
      @courses = @courses.where("Title = ?", params[:Title].to_s)
    end
    if params[:Instructor].to_s != ''

    end
    if params[:Description].to_s != ''
      @courses = @courses.where("Description = ?", params[:Description].to_s)
    end
    if params[:Status].to_s != ''
      @courses = @courses.where("Status = ?", params[:Status].to_s)
    end

    @courses = @courses.order('created_at DESC')
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