class RemoveIntrFromCourse < ActiveRecord::Migration
  def change
  	remove_column :courses, :Instructor, :string
  end
end
