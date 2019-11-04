eventCalendar = ->
  $('#event_calendar').each ->
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
          # start: event.start.format()
          # end: event.end.format()
          # start: event.start_date.format()
          # end: event.end_date.format()
          # start: event.start_date
          # end: event.end_date
          # start: event.start
          # end: event.end
          start_date: event.start.format()
          end_date: event.end.format()
        $.ajax
          url: event.update_url
          beforeSend: (xhr) ->
            xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
            return
          data: event_data
          type: 'PATCH'
          # success: (response) ->
          # console.log 'response'
        return
      eventClick: (event, jsEvent, view) ->
        $.getScript event.edit_url, ->
        return
    return
  return

clearCalendar = ->
  $('#event_calendar').html ''
  return

$(document).on 'turbolinks:load', eventCalendar
$(document).on 'turbolinks:before-cache', clearCalendar
