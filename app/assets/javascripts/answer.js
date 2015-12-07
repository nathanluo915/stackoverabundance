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
  };

  var bindCancelButton = function(event){
    event.preventDefault();
    var element = $(event.target);
    element.find("textarea").val("");
    element.parent().parent().toggle();
    element.parent().parent().parent().find(".add-comment-button").toggle();
  }

  var bindCheckMark = function(event){
    event.preventDefault();
    var element = $(event.target);
    $.ajax({
      method: "post",
      url: element.attr("action"),
      data: element.serialize()
    }).done(function(response){

      $.ajax({
        method: 'get',
        url: 'empty-check-mark',
        data: $.param({"answer-id": $("#best-answer-check").attr("answer-id")})
      }).done(function(innerResponse){
        $("#best-answer-check").parent().html(innerResponse);
        element.parent().html(response);
      }).fail(function(error){
        console.log(error);
      });

    }).fail(function(error){
      console.log(error);
    });
  }

  $(".best-answer-check").on("submit", bindCheckMark);

  $(".answer-form").on("submit", "form", function(event){
    event.preventDefault();
    var element = $(event.target);
    $.ajax({
      method: "post",
      url: element.attr("action"),
      data: element.serialize()
    }).done(function(response){
      $(".answer-list").append(response);
      $(".answer-list").children().last().find(".add-comment-button").on("click", bindAddComment);
      $(".answer-list").children().last().find(".comment-form-container").on("submit", "form", bindCommentSubmit);
      $(".answer-list").children().last().find(".cancel").on("click", bindCancelButton);
      $(".answer-list").children().last().find(".best-answer-check").on("submit", bindCheckMark);
      element.find("textarea").val("");
    }).fail(function(error){
      console.log(error);
    })
  })

  $(".add-comment-button").on("click", bindAddComment);
  $(".cancel").on("click", bindCancelButton);

  $(".comment-form-container").on("submit", "form", bindCommentSubmit);

});
