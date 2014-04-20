$(document).ready(function(){
  $("#member_inputs").on("click", "a.delete_x_member_input", function(e){
    e.preventDefault();
    $(this).closest(".member_input").remove();
  });
});
  
