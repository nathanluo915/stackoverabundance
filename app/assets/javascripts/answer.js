$(document).ready(function(){

  $("#post-answer").on("click", function(event){
    event.preventDefault();
    var element = $(event.target);
    element.toggle();
    $.ajax({
      method: "get",
      url: element.attr("href")
    }).done(function(response){
      debugger
      $(".answer-form").append(response);
    }).fail(function(error){
      console.log(error);
    });

  });


});
