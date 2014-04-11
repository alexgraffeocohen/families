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
  $(".album_name").on("click", function(e){
    e.preventDefault();
    var oldVal = $(".hidden").val();
    $(".hidden").removeClass("hidden").css("display", "inline").focus().val(oldVal);
    $(".album_name").hide();
  })
  
  $(".input_name").on("blur", function(){
    saveTask($(this).val());
  })

  function saveTask(val_arg){
    var newName = val_arg
    $(".input_name").addClass("hidden")
    $(".album_name").val(newName).show();
    var album_id = $(".album_name").data("id")
    var family_id = $(".album_name").data("family")

    $.ajax({
      url: "/families/" + family_id + "/albums/" + album_id,
      dataType: "script",
      method: "PATCH",
      data: {album: {name: newName}, album_id: album_id}
    });    
  }
});

