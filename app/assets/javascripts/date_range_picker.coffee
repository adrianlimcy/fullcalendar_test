# date_range_picker = undefined
#
# date_range_picker = ->
#   $('.date-range-picker').each ->
#     $(this).daterangepicker {
#       timePicker: true
#       timePickerIncrement: 30
#       alwaysShowCalendars: true
#     }, (start, end, label) ->
#       $('.start_hidden').val start.format('YYYY-MM-DD HH:mm')
#       $('.end_hidden').val end.format('YYYY-MM-DD HH:mm')
#       return
#     return
#   return


# date_range_picker = ->
#   $('input[class="date-range-picker"]').daterangepicker()
#   return
#
# clear_date_range_picker = ->
#   $('.date-range-picker').html ''
#   return

# $(document).on 'turbolinks:load', date_range_picker
# $(document).on 'turbolinks:before-cache', clear_date_range_picker
