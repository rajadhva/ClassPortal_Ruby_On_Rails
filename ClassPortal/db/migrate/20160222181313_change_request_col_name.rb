class ChangeRequestColName < ActiveRecord::Migration
  def change
  	rename_column :requests, :user_id, :student_id
  	rename_column :enrollments, :user_id, :student_id
  end
end
