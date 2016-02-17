class UsersController < ApplicationController
#before_filter :authenticate_user!
  def new 
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    @user.student = false
    if @user.roles == 'Admin'
      @user.admin = true
    elsif @user.roles == 'Instructor'
      @user.instructor = true
    elsif @user.roles == 'Student'
      @user.student = true
    end

    if @user.save
      flash[:success] = "User Created Successfully!!"
      if !current_user.nil? 
        redirect_to users_index_path
      else
        redirect_to login_url
      end
    else
        if !current_user.nil?
         render 'new'
        else
          render 'users/new'
        end
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def destroy
  User.find(params[:id]).destroy
  flash[:success]="User Removed"
  redirect_to request.referrer
  end

  
  def index
    @users=User.all
    if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
    else
    @users = User.all.order('created_at DESC')
    end
  end
  
  def edit
    @user=User.find(params[:id])
  end

  def update
    puts params[:id]
    puts params[:email]
    @user=User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_index_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: users_index_path }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    @users=User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end
	
private
    # Use callbacks to share common setup or constraints between actions.

      # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id,:name, :email, :password, :password_confirmation, :roles)
    end
end
