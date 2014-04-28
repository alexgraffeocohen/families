$(document).ready(function(){
  $("#demo-user-btn").on("click", function(e){
    e.preventDefault();
    $(".hidden-email-field").val("marcia@brady.com");
    $(".hidden-password-field").val("foobar12");
    $("form").submit();
  });
});