json.array!(@inactive_requests) do |inactive_request|
  json.extract! inactive_request, :id
  json.url inactive_request_url(inactive_request, format: :json)
end
