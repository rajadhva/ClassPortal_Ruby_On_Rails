class AdminsController < ApplicationController
before_filter :authenticate_user!

def welcome
  
 
end

 def index
    @users=User.all
    if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.all.order('created_at DESC')
  end
  end
  
def show
    @user = User.find(params[:id])
  end 


private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :member)
  end


end
