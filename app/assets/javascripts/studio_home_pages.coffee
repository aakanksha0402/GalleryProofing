# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  tinymce.init
    selector: '#studio_home_page_about'
    menubar: false
    plugins: 'link image'
    toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'
  $('.checkbox input').click ->
    if $(this).is(':checked')
      $(this).parent('.checkbox').addClass 'checked-box'
    else
      $(this).parent('.checkbox').removeClass 'checked-box'
    return
  return
