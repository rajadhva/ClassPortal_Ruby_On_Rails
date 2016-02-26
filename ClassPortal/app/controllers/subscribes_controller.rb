class SubscribesController < ApplicationController
  before_action :set_subscribe, only: [:show, :edit, :update, :destroy]

  # GET /subscribes
  # GET /subscribes.json
  def index
    @subscribes = Subscribe.all
  end

  # GET /subscribes/1
  # GET /subscribes/1.json
  def show
  end

  # GET /subscribes/new
  def new
    @subscribe = Subscribe.new
  end

  # GET /subscribes/1/edit
  def edit
  end

  # POST /subscribes
  # POST /subscribes.json
  def create
    @subscribe = Subscribe.new
    @subscribe.user = current_user.email
    @subscribe.course = params[:course]
    @sub=Subscribe.where(:user => current_user.email).where(:course => params[:course])
    if @sub.length==0
      if @subscribe.save
        #SubscribeMailer.sample_email(current_user).deliver_now
        #flash[:success] = "The course #{@subscribe.course} is subscribed successfully!"
        #redirect_to '/'
        respond_to do |format|
          format.html { redirect_to '/', notice: 'The course #{@subscribe.course} is subscribed successfully!' }
          format.json { head :no_content }
        end

      else
        render 'new'
      end
    else
      respond_to do |format|
        format.html { redirect_to '/', notice: 'The course #{@subscribe.course} is subscribed successfully!' }
        format.json { head :no_content }
        end
        #flash[:success] = "The course #{@subscribe.course} is already Subscribed by you!"
      #redirect_to '/'
    end
  end

  # PATCH/PUT /subscribes/1
  # PATCH/PUT /subscribes/1.json


  # DELETE /subscribes/1
  # DELETE /subscribes/1.json
  def destroy
    @subscribe.destroys
    respond_to do |format|
      format.html { redirect_to subscribes_url, notice: 'Subscribe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscribe
      @subscribe = Subscribe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscribe_params
      params.require(:subscribe).permit(:user, :course)
    end
end
