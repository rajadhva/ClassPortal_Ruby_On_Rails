class ChangeInstrColName < ActiveRecord::Migration
  def change
  	rename_column :course_instructors, :user_id, :instructor_id
  end
end
