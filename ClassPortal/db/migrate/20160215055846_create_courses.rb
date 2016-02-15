class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :Title
      t.string :Description
      t.string :Instructor
      t.date :Startdate
      t.date :Enddate
      t.string :Status

      t.timestamps null: false
    end
  end
end
