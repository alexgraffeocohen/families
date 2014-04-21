$(document).ready(function() {
  $('.image_link').magnificPopup({type: 'image'});

  $(".album_name").on("click", function(e){
    e.preventDefault();
    var oldVal = $(".hidden").val();
    $(".hidden").removeClass("hidden").css("display", "inline").focus().val(oldVal);
    $(".album_name").hide();
  })
  
  $(".input_name").bind("blur keyup", function(e){
    if (e.type == 'blur' || e.keyCode == '13')
    saveName($(this).val());
  })

  function saveName(val_arg){
    var newName = val_arg
    $(".input_name").addClass("hidden")
    $(".album_name").text(newName).show();
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

