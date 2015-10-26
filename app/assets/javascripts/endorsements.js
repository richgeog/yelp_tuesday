$(document).ready(function() {
  $('.endorsements-link').on('click', function(event){
    event.preventDefault();

    var endorsementCount = $(this).siblings('.endorsements_count');

    $.post(this.href, function(response){
      endorsementCount.text(respsonse.new_endorsement_count);
    })
  })
})