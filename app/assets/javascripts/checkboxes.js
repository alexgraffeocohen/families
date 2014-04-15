$(document).ready(function(){
  $("input.family").on("click", function(){
    var family_id = $("nav li.family").data("id")
    $.ajax({
      url: "/permissions/" + family_id + "/group",
      dataType: "script",
      method: "GET",
      data: {permissions: this.value}
      });
  });

  $("input.custom").on("click", function(){
    var family_id = $("nav li.family").data("id")
    $.ajax({
      url: "/permissions/" + family_id + "/individual",
      dataType: "script",
      method: "GET",
      data: {permissions: this.value}
      });
  });
});