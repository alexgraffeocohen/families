$(function(){
  if($(".message_all").length > 0){
    setTimeout(checkNewMessages, 5000);
  }
});

function checkNewMessages () {
  var convo_id = $("h2").data("id")
  var after = $(".message").last().data("time");
  $.getScript("messages.js?conversation_id=" + convo_id + "&after=" + after);
  setTimeout(checkNewMessages, 5000);
}