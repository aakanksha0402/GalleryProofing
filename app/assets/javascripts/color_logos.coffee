# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  selected_option = $('#color_logo_font_set').val()
  if selected_option == 'A - Branadon, Baskerville'
    $('.effects-from-font-set').css 'font-family', 'Arial'
  else if selected_option == 'B- ProximaNova'
    $('.effects-from-font-set').css 'font-family', 'Comic Sans MS'
  else if selected_option == 'C - Baskerville, OpenSans'
    $('.effects-from-font-set').css 'font-family', 'Verdana'
  selected_option = $('#color_logo_theme').val()
  if selected_option == 'Light'
    $('.effects-from-theme').css 'background-color', '#ffffff'
    $('.effects-from-secondary-color-links').css 'color', 'white'
    $('.effects-from-secondary-background-color').css 'background-color', 'black'
  else if selected_option == 'Dark'
    $('.effects-from-theme').css 'background-color', '#242424'
    $('.effects-from-secondary-color-links').css 'color', 'black'
    $('.effects-from-secondary-background-color').css 'background-color', 'white'
  $('.effects-from-primary-color').css 'color', $('#color_logo_primary_color').val()
  $('.effects-from-secondary-color').css 'color', $('#color_logo_secondary_color').val()
  $('.effects-from-primary-background-color').css 'background-color', $('#color_logo_primary_color').val()
  $('.effects-from-secondary-background-color').css 'background-color', $('#color_logo_secondary_color').val()
  return
