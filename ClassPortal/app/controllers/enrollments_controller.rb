class EnrollmentsController < ApplicationController
  # before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json

  def index
    @courses = Course.find(params[:course_id])
    @enrollments = Enrollment.search_by_course(params[:course_id])

    @students = []

    @enrollments.each do |e|
      @students << Student.find(e.student_id)
    end
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
    @course = Course.find(params[:id])
    @enrollments = Enrollment.where("course_id = ?", params[:id].to_s)
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
    @enrollment.course_id = params[:course_id]

    @students = User.where(:student => 1)

    @unenrolled = []

    @students.each do |s|
      result = Enrollment.search_by_student_course(s.id,params[:course_id])
      
      if result.empty?
        @unenrolled << s
      end
    end
    

  end

  # GET /enrollments/1/edit
  def edit
    @enrollment=Enrollment.find(params[:id])
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new
    @enrollment.student_id = params[:enrollment][:student]
    @enrollment.course_id = params[:enrollment][:course_id]
    
    if !@enrollment.student_id.nil? and !@enrollment.course_id.nil?
      @enrollment.save
    end
    redirect_to enrollments_index_path(:course_id=>@enrollment.course_id) 
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    @enrollment = Enrollment.find(params[:id])
      if @enrollment.update(enrollment_params)
        redirect_to enrollments_index_path(:course_id=>@enrollment.course_id) 
      end
    
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment=Enrollment.find(params[:id])
    if @enrollment.present?
    @enrollment.destroy
    end
    redirect_to request.referrer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:course_id,:student_id, :grade)
    end
end
