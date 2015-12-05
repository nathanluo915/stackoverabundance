$(document).ready(function(){
  $(".score-block").on("submit", function(event){
    event.preventDefault();
    var targ = event.target
    $.ajax({
      url: event.target.action,
      method: event.target.method,
      data: $(event.target).serialize(),
      dataType: 'html'
    }).done(function(response){
      $(targ).parent().parent().html(response);
    }).fail(function(error){
      console.log(error);
    });
  });
});
