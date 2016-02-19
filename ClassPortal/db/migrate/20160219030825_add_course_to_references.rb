class AddCourseToReferences < ActiveRecord::Migration
  def change
    add_reference :references, :course, index: true, foreign_key: true
  end
end
