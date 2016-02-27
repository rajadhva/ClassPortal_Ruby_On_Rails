class InactiveRequestsController < ApplicationController
  before_action :set_inactive_request, only: [:show, :edit, :update, :destroy]

  # GET /inactive_requests
  # GET /inactive_requests.json
  def index
     if current_user.instructor
      @inactive_requests = InactiveRequest.where(:instructor_id=>current_user.id)
    elsif current_user.admin or current_user.super
      @inactive_requests = InactiveRequest.all
    end
  end

  # GET /inactive_requests/1
  # GET /inactive_requests/1.json
  def show
    @instructor = Instructor.new(params[@inactive_request.instructor_id])
    @course = Course.new(params[@inactive_request.course_id])
  end

  # GET /inactive_requests/new
  def new
    @count=InactiveRequest.all
    @count = InactiveRequest.search_by_user_course(params[:instructor_id],params[:course_id])
    @inactive_request = InactiveRequest.new
    @inactive_request.course_id = params[:course_id]
  end

  # GET /inactive_requests/1/edit
  def edit
  end

  # POST /inactive_requests
  # POST /inactive_requests.json
  def create
   @inactive_request = InactiveRequest.new(inactive_request_params)

    if @inactive_request.save
      redirect_to courses_index_path
    else
      redirect_to :back
    end
  end

  # PATCH/PUT /inactive_requests/1
  # PATCH/PUT /inactive_requests/1.json
  def update
   if @inactive_request.update(inactive_request_params)

      if @inactive_request.Status == 'Approved'
        @course = Course.find(@inactive_request.course_id)
        @course.update_attribute(:Status,'Inactive')
      end 

        redirect_to inactive_requests_index_path
      else
        redirect_to :back
      end
  end

  # DELETE /inactive_requests/1
  # DELETE /inactive_requests/1.json
  def destroy
     @inactive_request.destroy
    respond_to do |format|
      format.html { redirect_to inactive_requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inactive_request
      @inactive_request = InactiveRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inactive_request_params
       params.require(:inactive_request).permit(:instructor_id, :course_id, :Status)
    end
end
