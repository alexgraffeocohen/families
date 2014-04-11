$(document).ready(function() {
  $('.image_link').magnificPopup({type: 'image' });
  $("a:contains('Entire Family')").on("click", function(e){
    e.preventDefault();
    $('input[type=checkbox]').trigger('click');
  })
  $("a:contains('Custom')").on("click", function(e){
    e.preventDefault();
    $('.customize').slideToggle();
  })
  $("a:contains('Edit')").on("click", function(e){
    e.preventDefault();
    $(".album_name").hide();
    $(".hidden").show();
  })
});

