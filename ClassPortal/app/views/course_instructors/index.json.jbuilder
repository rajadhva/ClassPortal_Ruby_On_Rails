json.array!(@course_instructors) do |course_instructor|
  json.extract! course_instructor, :id, :course_id, :user_id
  json.url course_instructor_url(course_instructor, format: :json)
end
