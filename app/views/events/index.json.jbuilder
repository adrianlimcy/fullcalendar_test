# json.array! @events, partial: "events/event", as: :event

json.array! @events do |event|
  date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  # date_format = '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.title
  json.description event.description
  json.start event.start_date.strftime(date_format)
  json.end event.end_date.strftime(date_format)
  # json.color event.color unless event.color.blank?
  json.allDay event.all_day_event? ? true : false
  json.update_url event_path(event, method: :patch)
  # json.update_url edit_event_path(event)
  json.edit_url edit_event_path(event)
end
