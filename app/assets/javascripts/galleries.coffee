$(document).ready ->
  tinymce.init
    selector: '#gallery_share_message'
    menubar: false
    plugins: 'link image'
    toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'
  
