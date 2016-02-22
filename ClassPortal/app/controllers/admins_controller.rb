class AdminsController < ApplicationController
before_filter :authenticate_user!

def welcome
  
 
end

  def destroy
  Admin.find(params[:id]).destroy
  
  flash[:success]="Admin Removed"
  redirect_to request.referrer
  end

 def index
    @admins=Admin.all
    if params[:search]
    @admin = Admin.search(params[:search]).order("created_at DESC")
  else
    @admins = Admin.all.order('created_at DESC')
  end
  end
  
def show
    @admin = Admin.find(params[:id])
  end 


private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
