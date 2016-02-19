class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @user = User.new(params[@request.user_id])
    @course = Course.new(params[@request.course_id])
  end

  # GET /requests/new
  def new
    @count=Request.all
    @count = Request.search_by_user_course(params[:user_id],params[:course_id])
    @request = Request.new
    @request.course_id = params[:course_id]
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create


    @request = Request.new(request_params)
   
    if @request.save
      redirect_to courses_index_path
    else
      redirect_to :back
    end

  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update

      if @request.update(request_params)

      if @request.Status == 'Approved'
        @enrollment = Enrollment.new
        @enrollment.user_id = @request.user_id
        @enrollment.course_id = @request.course_id
        @enrollment.save
      end 

        redirect_to requests_index_path
      else
        redirect_to :back
      end
    
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:user_id, :course_id, :Status)
    end
end
