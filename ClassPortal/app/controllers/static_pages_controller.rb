class StaticPagesController < ApplicationController
	def new
		puts current_user.inspect
		if current_user!=nil
			if current_user.admin or current_user.super
		  	 	redirect_to admins_welcome_path
		  	elsif current_user.instructor
		   		redirect_to instructors_welcome_path
		  	elsif current_user.student
		   		redirect_to students_welcome_path
		   	end
		end
	end
	
	def about
	end

	def todo
		end
end
