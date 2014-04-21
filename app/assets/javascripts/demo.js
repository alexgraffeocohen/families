$(document).ready(function(){
  $("#demo-user-btn").on("click", function(e){
    $(".hidden-email-field").val("demo-user@heatseeknyc.com");
    $(".hidden-password-field").val("33west26");
    $("form").submit();
  });
});