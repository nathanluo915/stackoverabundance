$(document).ready(function(){

  var bindAddComment = function(event){
    event.preventDefault();
    var element = $(event.target);
    element.toggle();
    element.next().toggle();

  };

  $("#post-answer").on("click", function(event){
    event.preventDefault();
    var element = $(event.target);
    element.toggle();
    element.parent().find("form").toggle();
  });

  $(".answer-form").on("submit", "form", function(event){
    event.preventDefault();
    var element = $(event.target);
    $.ajax({
      method: "post",
      url: element.attr("action"),
      data: element.serialize()
    }).done(function(response){
      $(".answer-list").append(response);
      $()
      $("#post-answer").toggle();
      element.find("textarea").val("");
      element.toggle();
    }).fail(function(error){
      console.log(error);
    })
  })



  $(".add-comment-button").on("click", bindAddComment);

  $(".comment-form-container").on("submit", "form", function(event){
    event.preventDefault();
    var element = $(event.target);

    $.ajax({
      method: "post",
      url: element.attr("action"),
      data: element.serialize()
    }).done(function(response){
      element.parent().parent().children(".comment-list").append(response);
      element.find("textarea").val("");
      element.toggle();
      element.prev().toggle();
    }).fail(function(error){
      console.log(error);
    });

  });

});
