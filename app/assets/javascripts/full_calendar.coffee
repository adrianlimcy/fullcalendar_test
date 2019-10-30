initialize_calendar = undefined

initialize_calendar = ->
  $('.calendar').each ->
    calendar = $(this)
    calendar.fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,agendaWeek,agendaDay'
      selectable: true
      selectHelper: true
      editable: true
      eventLimit: true
      events: '/events.json'
      select: (start, end) ->
        $.getScript '/events/new', ->
        calendar.fullCalendar 'unselect'
        return
      eventDrop: (event, delta, revertFunc) ->
        event_data = event:
          id: event.id
          start: event.start.format()
          end: event.end.format()
        $.ajax
          url: event.update_url
          data: event_data
          type: 'PATCH'
        return
      eventClick: (event, jsEvent, view) ->
        $.getScript event.edit_url, ->
        return
    return
  return

$(document).on 'turbolinks:load', initialize_calendar
