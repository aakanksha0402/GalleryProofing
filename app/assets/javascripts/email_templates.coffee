# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ($) ->
  $('#email_template_id').change ->
    selected_id = $('#email_template_id').val()
    if selected_id == ''
      $('#edit_email_body').css 'display', 'none'
      $('#email_template_email_subject').prop 'disabled', true
      $('#email_template_headline').prop 'disabled', true
      $('#email_template_button_text').prop 'disabled', true
      $('#email_template_email_body').prop 'disabled', true
      $('#content_email_preview').addClass 'email-template-no'
      $('#copyright_email_preview').addClass 'email-template-no'
      $('#hideForEmailTemplate').css 'display', 'none'
      $('#email_template_email_subject').val ''
      $('#email_template_headline').val ''
      $('#email_template_button_text').val ''
      $('#email_template_email_body').val ''
      $('#save_email_template').prop 'disabled', true
    else
      $.ajax
        type: 'GET'
        url: '/default_email_templates/' + selected_id + '.json'
        dataType: 'json'
        success: (data) ->
          tinymce.init selector: '#email_template_email_body'
          $('#email_template_email_body_ifr').contents().find('body').html data.email_body
          $('#edit_email_body').css 'display', 'block'
          $('#email_template_email_subject').prop 'disabled', false
          $('#email_template_headline').prop 'disabled', false
          $('#email_template_button_text').prop 'disabled', false
          $('#email_template_email_body').prop 'disabled', false
          $('#content_email_preview').removeClass 'email-template-no'
          $('#copyright_email_preview').removeClass 'email-template-no'
          $('#hideForEmailTemplate').css 'display', 'block'
          if data.text_for_button != null
            $('#text-after-select').text data.text_after_select
          if data.text_for_button != null
            $('#text-for-button').text data.text_for_button
          if data.button_text == null
            $('#preview_button').addClass 'email-template-no'
            $('#label_button_text').css 'display', 'none'
            $('#email_template_button_text').css 'display', 'none'
          else
            $('#label_button_text').css 'display', 'block'
            $('#email_template_button_text').css 'display', 'block'
            $('#preview_button').removeClass 'email-template-no'
            $('#preview_button').text data.button_text
          $('#email_template_email_subject').val data.email_subject
          $('#email_template_headline').val data.headline
          $('#email_template_button_text').val data.button_text
          $('#email_template_email_body').val data.email_body
          $('#preview_subject').text data.email_subject
          $('#hideDiv').remove()
          $('#preview_body').html data.email_body
          $('#save_email_template').prop 'disabled', false
          return
    return
  return
$ ->
  $('#email_template_email_body').keyup ->
    v = $('#email_template_email_body').val()
    $('#bodypreview').text v
    return
  $('#email_template_button_text').keyup ->
    v = $('#email_template_button_text').val()
    $('#preview_button').text v
    return
  $('#email_template_email_subject').keyup ->
    v = $('#email_template_email_subject').val()
    $('#preview_subject').text v
    return
  return
