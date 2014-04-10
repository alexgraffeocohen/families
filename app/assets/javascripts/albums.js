$(function(){
  $('.dropdown.keep-open').on({
      "shown.bs.dropdown": function() { $(this).data('closable', false); },
      "click":             function() { $(this).data('closable', true);  },
      "hide.bs.dropdown":  function() { return $(this).data('closable'); }
  });
});