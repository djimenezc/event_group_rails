json.array!(@group_events) do |group_event|
  json.extract! group_event, :id
  json.url group_event_url(group_event, format: :json)
end
