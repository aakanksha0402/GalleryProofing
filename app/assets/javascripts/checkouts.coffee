# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  if $('#checkout_same_billing_address').prop('checked') == true
    $('.checkbox').addClass 'checked-box'
    $('#billing_info_row').hide()
  if $('#checkout_payment_option_false').prop('checked') == true
    $('#pay_later_row').hide()
  if $('#checkout_shipping_method_false').prop('checked') == true
    $('#shipping_row').hide()
  return
