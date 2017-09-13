ready = undefined
set_positions = undefined

set_positions = ->
  # loop through and give each task a data-pos
  # attribute that holds its position in the DOM
  $('.category').each (i) ->
    $(this).attr 'data-pos', i + 1
    return
  return

ready = ->
  # call set_positions function
  set_positions()
  $('.sortable').sortable()
  # after the order changes
  $('.sortable').sortable().bind 'sortupdate', (e, ui) ->
    # array to store new order
    updated_order = []
    # set the updated positions
    set_positions()
    # populate the updated_order array with the new task positions
    $('.category').each (i) ->
      updated_order.push
        id: $(this).data('id')
        position: i + 1
      return
    # send the updated order via ajax
    $.ajax
      headers: 'X-CSRF-Token': '<%= form_authenticity_token.to_s %>'
      type: 'PUT'
      url: '/categories/sort'
      data: order: updated_order
    return
  return

$(document).ready ready
