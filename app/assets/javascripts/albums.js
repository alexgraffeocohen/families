$(document).ready(function() {
  $('.image_link').magnificPopup({type: 'image' });
  $("a:contains('Entire Family')").on("click", function(e){
    e.preventDefault();
    $('input[type=checkbox]').trigger('click');
  })
});

