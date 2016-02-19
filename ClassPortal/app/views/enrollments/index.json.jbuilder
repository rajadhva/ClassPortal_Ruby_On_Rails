json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id
  json.url enrollment_url(enrollment, format: :json)
end
