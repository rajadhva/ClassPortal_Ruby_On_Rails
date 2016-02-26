class UsersController < ApplicationController
#before_filter :authenticate_user!
  def new 
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    
    if @user.roles == 'Admin'
      @user.admin = true
      @user.student = false
    elsif @user.roles == 'Instructor'
      @user.instructor = true
      @user.student = false
    elsif @user.roles == 'Student'
      @user.student = true
    end

    if @user.save
      flash[:success] = "User Created Successfully!!"
      if !current_user.nil? 
        redirect_to users_index_path
      else
        redirect_to root_path
      end
    else
        if !current_user.nil?
         render 'new'
        else
          render 'users/new'
        end
    end
  end


  def destroy
  User.find(params[:id]).destroy
  
  flash[:success]="User Removed"
  redirect_to request.referrer
  end

  def show
    @user = User.find(params[:id])
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
    @user=User.find(params[:id])
      if @user.update(user_params)
        if(@user.admin or @user.super)
          redirect_to users_index_path
        elsif @user.student
          redirect_to students_welcome_path
        elsif @user.instructor
          redirect_to instructors_welcome_path
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

  def password
    @user=User.find(current_user.id)
    puts "==================================================="
    puts @user.inspect
    puts "==================================================="
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "password"
    end
  end
	
private
    # Use callbacks to share common setup or constraints between actions.

      # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id,:name, :email, :password, :password_confirmation, :roles)
    end
end
