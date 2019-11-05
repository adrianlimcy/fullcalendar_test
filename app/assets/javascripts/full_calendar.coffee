date_range_picker = undefined

date_range_picker = ->
  $('.date-range-picker').each ->
    $(this).daterangepicker {
      timePicker: true
      timePickerIncrement: 30
      alwaysShowCalendars: true
    }, (start, end, label) ->
      $('.start_hidden').val start.format('YYYY-MM-DD HH:mm')
      $('.end_hidden').val end.format('YYYY-MM-DD HH:mm')
      return
    return
  return

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
          $('#event_date_range').val moment(start).format('MM/DD/YYYY HH:mm') + ' - ' + moment(end).format('MM/DD/YYYY HH:mm')
          date_range_picker()
          $('.start_hidden').val moment(start).format('YYYY-MM-DD HH:mm')
          $('.end_hidden').val moment(end).format('YYYY-MM-DD HH:mm')
          return
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
        return
      eventClick: (event, jsEvent, view) ->
        $.getScript event.edit_url, ->
          $('#event_date_range').val moment(event.start).format('MM/DD/YYYY HH:mm') + ' - ' + moment(event.end).format('MM/DD/YYYY HH:mm')
          date_range_picker()
          $('.start_hidden').val moment(event.start).format('YYYY-MM-DD HH:mm')
          $('.end_hidden').val moment(event.end).format('YYYY-MM-DD HH:mm')
          return
        return
    return
  return

clearCalendar = ->
  $('#event_calendar').html ''
  return
clear_date_range_picker = ->
  $('.date-range-picker').html ''
  return

$(document).on 'turbolinks:load', ->
  date_range_picker()
  eventCalendar()
  return

$(document).on 'turbolinks:before-cache', ->
  clearCalendar()
  clear_date_range_picker()
  return
