$(document).ready(function(){
  $("#post-answer").on("click", function(event){
    event.preventDefault();
    var element = $(event.target);
    element.toggle();
    $.ajax({
      method: "get",
      url: element.attr("href")
    }).done(function(response){
      $(".answer-form").append(response);
    }).fail(function(error){
      console.log(error);
    });

  });

  $(".answer-form").on("submit", "form", function(event){
    event.preventDefault();
    var element = $(event.target);
    $.ajax({
      method: "post",
      url: element.attr("action"),
      data: element.serialize()
    }).done(function(response){
      debugger
      element.parent().remove();
      $(".answer-list").append(response);
      $("#post-answer").toggle();
    }).fail(function(error){
      console.log(error);
    })
  })


});
