json.array!(@courses) do |course|
  json.extract! course, :id, :Title, :Description, :Instructor, :Startdate, :Enddate, :Status
  json.url course_url(course, format: :json)
end
