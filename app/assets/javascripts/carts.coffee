# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('input[name="quantity"]').each ->
    if $(this).val() == '1'
      $(this).parent().find('button[id^="quantity-reduce"]').prop 'disabled', true
    return
  return
