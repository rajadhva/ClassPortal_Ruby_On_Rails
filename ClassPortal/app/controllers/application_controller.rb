class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 # before_action :authenticate_user!

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

 def after_sign_in_path_for(resource_or_scope)
 		if current_user.admin or current_user.super
	       admins_welcome_path
	   elsif current_user.instructor
	   		instructors_welcome_path
	   	else 
	   		students_welcome_path
	   end
  end

  

end
