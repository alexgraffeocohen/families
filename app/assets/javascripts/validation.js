$(document).ready(function(){
  $("div.new_sign_up form.new_person").on("submit", function(e){
    if ($("div.new_sign_up input[type=radio]:checked").length > 0){

    } else {
      e.preventDefault();
      $("div.container").prepend("<div class='alert alert-danger alert-dismissable remove'>You Must Select a Gender.<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button></div>")
      $("div.remove").fadeOut(3000);
    } 
  });
});