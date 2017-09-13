$(document).ready ->
  $('input[type="checkbox"]').change ->
    v = $(this).attr('id')
    checked = $(this).prop('checked')
    if checked == true
      if v.match('_view$')
        $(this).parent().parent().parent().parent().find('input[id^=\'view_\']').parent().addClass 'checked-box'
        $(this).parent().parent().parent().parent().find('input[id^=\'view_\']').prop 'checked', true
      if v.match('_edit$')
        $(this).parent().parent().parent().parent().find('input[id^=\'edit_\']').parent().addClass 'checked-box'
        $(this).parent().parent().parent().parent().find('input[id^=\'edit_\']').prop 'checked', true
      if v.match('_add$')
        $(this).parent().parent().parent().parent().find('input[id^=\'add_\']').parent().addClass 'checked-box'
        $(this).parent().parent().parent().parent().find('input[id^=\'add_\']').prop 'checked', true
    else
      if v.match('_view$')
        $(this).parent().parent().parent().parent().find('input[id^=\'view_\']').parent().removeClass 'checked-box'
        $(this).parent().parent().parent().parent().find('input[id^=\'view_\']').prop 'checked', false
      if v.match('_edit$')
        $(this).parent().parent().parent().parent().find('input[id^=\'edit_\']').parent().removeClass 'checked-box'
        $(this).parent().parent().parent().parent().find('input[id^=\'edit_\']').prop 'checked', false
      if v.match('_add$')
        $(this).parent().parent().parent().parent().find('input[id^=\'add_\']').parent().removeClass 'checked-box'
        $(this).parent().parent().parent().parent().find('input[id^=\'add_\']').prop 'checked', false
    return
  $('input[type="checkbox"][id^="edit_"]').change ->
    select = $(this).parent().parent().parent().find($('input[type="checkbox"][id^="view_"]'))
    if $(this).prop('checked') == true
      select.prop 'checked', true
      select.parent().addClass 'checked-box'
    return
  $('input[type="checkbox"][id^="all_select_"][id $="_edit').change ->
    section = $(this).attr('id').split('_')
    select = $('#all_select_' + section[2] + '_view')
    if $(this).prop('checked') == true
      select.prop 'checked', true
      select.parent().addClass 'checked-box'
      select.parent().parent().parent().parent().find('input[id^=\'view_\']').parent().addClass 'checked-box'
      select.parent().parent().parent().parent().find('input[id^=\'view_\']').prop 'checked', true
    return
  return
