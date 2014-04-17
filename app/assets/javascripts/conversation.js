$(function(){
  if($(".message_all").length > 0){
    setTimeout(checkNewMessages, 5000);
  }
});

function checkNewMessages () {
  if($(".message").length > 0){
    var convo_id = $("h2").data("id")
    var after = $(".message").first().data("time");
    var family_id = $("nav li.family").data("id")
    $.ajax({
      url: "/families/" + family_id + "/conversations/" + convo_id + "/check_messages",
      dataType: "script",
      method: "GET",
      data: {after: after}
      });
  }
  setTimeout(checkNewMessages, 5000);
}