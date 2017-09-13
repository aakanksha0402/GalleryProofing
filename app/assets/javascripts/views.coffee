$('.hide_unhide').click ->
  alert 'In'
  $.ajax
    type: 'GET'
    url: '/views/hide_unhide'
    data:
      id: image_id
      gallery: '<%= params[:gallery]%>'
      brand: '<%= params[:brand] %>'
  return
