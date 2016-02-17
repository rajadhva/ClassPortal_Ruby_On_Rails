class CourseColumnAdd < ActiveRecord::Migration
  def change
    add_column :courses, :CourseNumber, :string,:limit => 30
  end
end
