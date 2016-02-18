class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    for course in @courses
      if isActive(course.Startdate,course.Enddate)
        course.Status=true
      else
        course.Status=false
      end
    end

  end
  ``
  def new
    @courses = Course.all
  end
  # GET /courses/1
  # GET /courses/1.json
  def show
    @course=Course.find(params[:id])
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
    @startDate=@course.Startdate
    @endDate=@course.Enddate

    @course.Status=false
    if isActive(@startDate,@endDate)
      @course.Status=true
    else
      @course.Status=false
    end

    if @course.save
      flash[:success] = "The course is added successfully!"
      redirect_to courses_url
    else
      render 'new'
    end

  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update

    if isActive(@course.Startdate,@course.Enddate)
      @course.Status=true
    else
      @course.Status=false
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
    if params[:search]
      @courses = Course.search(params[:search]).order("created_at DESC")
    else
      @courses = Course.all.order('created_at DESC')
    end
  end

  #all helper methods are listed here

  def isActive(startDate,endDate)
    if (startDate<=Date.today and Date.today<=endDate)
      return true
    else
      return false
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:CourseNumber,:Title, :Description, :Instructor, :Startdate, :Enddate, :Status)
  end
end