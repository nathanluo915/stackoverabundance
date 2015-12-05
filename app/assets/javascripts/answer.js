$(document).ready(function(){

  var bindAddComment = function(event){
    event.preventDefault();
    var element = $(event.target);
    element.toggle();
    element.next().toggle();

  };

  var bindCommentSubmit = function(event){
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

  }

  $(".answer-form").on("submit", "form", function(event){
    event.preventDefault();
    var element = $(event.target);
    $.ajax({
      method: "post",
      url: element.attr("action"),
      data: element.serialize()
    }).done(function(response){
      $(".answer-list").append(response);
      $(".add-comment-button").on("click", bindAddComment);
      $(".comment-form-container").on("submit", "form", bindCommentSubmit);
      element.find("textarea").val("");
    }).fail(function(error){
      console.log(error);
    })
  })

  $(".add-comment-button").on("click", bindAddComment);

  $(".comment-form-container").on("submit", "form", bindCommentSubmit);

});
