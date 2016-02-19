class ReferencesController < ApplicationController
  def new
    @course=Course.find(params[:course_id])
    @reference = @course.references.new
  end

  def create
    @course=Course.find(params[:course_id])
    @reference = @course.references.new(ref_params)

    if @reference.save
      flash[:success] = "The reference is added successfully!"
      redirect_to courses_url
    else
      render 'new'
    end
  end

  def index
    @references = Course.find(params[:course_id]).references.all.sort_by { |r| r[:updated_at]}.reverse!
  end

  private
  def ref_params
    params.require(:reference).permit(:description, :url)
  end
end
