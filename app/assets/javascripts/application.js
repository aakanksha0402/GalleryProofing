// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require jquery.turbolinks
//= require lightbox-plus-jquery.min.js
//= require jquery-1.12.1.min.js
//= require jquery.sortable
//= require bootstrap.min.js
//= require bootstrap-select.min.js
//= require bootstrap-datetimepicker.min.js
//= require bootstrap-colorpicker.min.js
//= require bootstrap-switch
//= require bootstrap-tagsinput
//= require jquery-ui
//= require jquery_nested_form
//= require tinymce.min.js
//= require Chart.bundle
//= require chartkick
//= require categories
//= require color_logos
//= require discounts
//= require email_templates
//= require groups
//= require studio_home_pages
//= require refer_friends
//= require addtohomescreen
//= require galleries
//= require invoices
//= require user_permissions
//= require jquery.Jcrop
//= require jquery.flexslider-min.js
// require lightbox
//= require dropzone 
//= require lightview

$(document).ready(function(){
    $('#studio_name').keyup(function(e){
       	var v = $('#studio_name').val();
        $('#myhidden').val(v);
    });

    //On Sign Up
    $('#promoCode').click(function(){
      if($('#promo_code').css('display')=='none'){
          $('#promo_code').show();
      }
      else{
          $('#promo_code').hide();
      }
    });

    $(".clickable-row>td").click(function() {
      if($(this).hasClass('quick-actions') || $(this).hasClass('remove-link')){
      }
      else{
        window.document.location = $(this).parent().data("href");
      }
    });
});



//new email template in automation series
$(document).ready(function(){
  $("#automation_series_email_template_email_template_id").change(function(){
    var selected_id = $("#automation_series_email_template_email_template_id").val()
      $.ajax({
        type: "GET",
        url: "/email_templates/" + selected_id + ".json",
        dataType: 'json',
        success: function(data){
          // alert(data);
          $('#automation_series_email_template_template_name').val(data.name)
        }
      });
    });
  });



// $(function($) {
//     $("#Status").change(function() {
//       var selected_id = $("#Status").val()
//       alert(selected_id)
//       $.ajax({
//         type: "GET",
//         url: "/galleries?status=" + selected_id,
//         success: function(data){
//           if(selected_id == "All Open"){
//             location.href = "/galleries"
//           }
//           else {
//                 location.href = "/galleries?status=" + selected_id
//             }
//             $("#Status").setItem(selected_id),
//           console.log("/galleries?status=" + selected_id)
//         }
//     });
//   })
// });

$(document).ready(function($) {

    $("#notice").fadeOut(2000);
    $("<p></p>").appendTo("#notice1");

  //   $("#Status").change(function() {
  //     var selected_id = $("#Status").val()
  //
  //     $.ajax({
  //       type: "GET",
  //       url: "/galleries?status=" + selected_id,
  //       success: function(data){
  //         if(selected_id == "All Open"){
  //           location.href = "/galleries"
  //         }
  //         else {
  //               location.href = "/galleries?status=" + selected_id
  //           }
  //           $("#Status").setItem(selected_id),
  //         console.log("/galleries?status=" + selected_id)
  //       }
  //   });
  // })
});


$(function() {
  $(".businees-name>a").click(function (event) {
    $(this).next('.add-business-name').stop(true, false).toggle();
  });
  $("[name='my-checkbox']").bootstrapSwitch();
});

$(function(){
  $("#gallery_share_message").keyup(function(){
    var v = $("#gallery_share_message").val()
    $("#preview_body").text(v)
  });

  $("#gallery_share_buttontext").keyup(function(){
    var v = $("#gallery_share_buttontext").val()
    $("#preview_button").text(v)
  });

  $("#gallery_share_headline").keyup(function(){
    var v = $("#gallery_share_headline").val()
    $("#preview_subject").text(v)
  });
});

$(function() {
  $("#email_template").change(function() {
    var v = $("#email_template option:selected").data('t');
    // alert(v);
    if (v == "DefaultEmailTemplate") {
      var id = $("#email_template option:selected").val();
        $.ajax({
        type: "GET",
        success: function(data) {
          location.href = "/email_templates?email_template=" + id
        }
      });
      // alert("Hello");
    } else if (v == "AutomationSeries") {
      var id = $("#email_template option:selected").val();
      // alert(id);
      $.ajax({
        type: "GET",
        success: function(data) {
          location.href = "/email_templates?automation_series=" + id
        }
      });
      // alert("World");
    } else {
      $.ajax({
        type: "GET",
        success: function(data) {
          location.href = "/email_templates"
        }
      });
    }
  });
});

 $(document).ready(function(e) {
  //  $(".sitemenu .dropdown a").click(function(){
  //       $('.dropdown').removeClass("open");
  //  });

   $('.sitemenu .dropdown').hover(function() {
     $(this).addClass("open");
  },function(){
    $(this).removeClass("open");
  });

});

