$(document).ready(function(){
  $("a:contains('By Group')").on("click", function(e){
    e.preventDefault();
    $('.group_section').slideToggle();
  });

  $("a:contains('By Person')").on("click", function(e){
    e.preventDefault();
    $('.individual_section').slideToggle();
  });

  $("#family").on("click", function(e){
    $('input:checkbox').prop('checked', this.checked);
  });

  $("input.group").on("click", function(){
    var family_id = $("nav li.family").data("id")
    $.ajax({
      url: "/permissions/" + family_id + "/group",
      dataType: "script",
      method: "GET",
      data: {permissions: this.value}
      });
  });

  $("input.individual").on("click", function(){
    var family_id = $("nav li.family").data("id")
    $.ajax({
      url: "/permissions/" + family_id + "/individual",
      dataType: "script",
      method: "GET",
      data: {permissions: this.value}
      });
  });

});