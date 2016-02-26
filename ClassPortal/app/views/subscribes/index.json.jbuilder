json.array!(@subscribes) do |subscribe|
  json.extract! subscribe, :id, :user, :course
  json.url subscribe_url(subscribe, format: :json)
end
