$(document).ready(function(){
  $(document).on("click", "a.delete_x_member_input", function(e){
    e.preventDefault();
    if($("a.delete_x_member_input").size() > 1){
      $(this).closest(".member_input").remove();
    }
  });
});
  
