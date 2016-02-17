class UsersController < ApplicationController
#before_filter :authenticate_user!


def destroy
  User.find(params[:id]).destroy
  flash[:success]="User Removed"
  redirect_to referrer
  end


   def index
    @users=User.all
    if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.all.order('created_at DESC')
  end
  end

def create 
 @user = User.new(user_params)
 @user.student = false
    if @user.roles == 'Admin'
      @user.admin = true
    elsif @user.roles == 'Instructor'
      @user.instructor = true
    end

    puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ HERE"

    if @user.save
    flash[:success] = "User Created Successfully!!"
    if !current_user.nil? 
    redirect_to @user
    else
    redirect_to login_url
    end
    else
      if !current_user.nil?
      render 'new'
      else
      render 'members/new'
      end
    end

end

	def new 
    @user = User.new
	end

end
