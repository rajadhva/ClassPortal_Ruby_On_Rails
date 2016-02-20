class CourseInstructorsController < ApplicationController
  before_action :set_course_instructor, only: [:show, :edit, :update, :destroy]

  # GET /course_instructors
  # GET /course_instructors.json
  def index
    @course_instructors = CourseInstructor.all
  end

  # GET /course_instructors/1
  # GET /course_instructors/1.json
  def show
  end

  # GET /course_instructors/new
  def new
    @course_instructor = CourseInstructor.new
  end

  # GET /course_instructors/1/edit
  def edit
  end

  # POST /course_instructors
  # POST /course_instructors.json
  def create
    @course_instructor = CourseInstructor.new(course_instructor_params)

    respond_to do |format|
      if @course_instructor.save
        format.html { redirect_to @course_instructor, notice: 'Course instructor was successfully created.' }
        format.json { render :show, status: :created, location: @course_instructor }
      else
        format.html { render :new }
        format.json { render json: @course_instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_instructors/1
  # PATCH/PUT /course_instructors/1.json
  def update
    respond_to do |format|
      if @course_instructor.update(course_instructor_params)
        format.html { redirect_to @course_instructor, notice: 'Course instructor was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_instructor }
      else
        format.html { render :edit }
        format.json { render json: @course_instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_instructors/1
  # DELETE /course_instructors/1.json
  def destroy
    @course_instructor.destroy
    respond_to do |format|
      format.html { redirect_to course_instructors_url, notice: 'Course instructor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_instructor
      @course_instructor = CourseInstructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_instructor_params
      params.require(:course_instructor).permit(:course_id, :user_id)
    end
end
