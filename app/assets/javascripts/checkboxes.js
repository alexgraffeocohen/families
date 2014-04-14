$(document).ready(function(){
  $("input.family").on("click", function(){
    var family_id = $("nav li.family").data("id")
    $.ajax({
      url: "/families/" + family_id + "/permissions",
      dataType: "script",
      method: "GET",
      data: {permissions: this.value}
      });
  });
});