$(document).ready(function() {

  $(".main-form-slidedown").hide();

  $(".main-form-slidedown").on("submit", function(event) {
    event.preventDefault();
     $.ajax({
      url: $("#new_question").attr("action"),
      method: "post",
      data: $("#new_question").serialize(),
    }).done(function(response){
      console.log(response);
      if (response == "Success") {
        $(".main-form-slidedown").slideUp();
      }
      else {
        for (i = 0; i < response.length; i++)
        $(".new-question-form-errors").append("<p>"+ response[i] +"</p>");
      }

    });

  });



 $("#Ask-question-button").click(function(event) {
  event.preventDefault();
  $.ajax({
    url: "/questions/new"
  }).done(function(response) {
    div =  $(".main-form-slidedown");
    div.html(response);
     $("#new-question-form-cancel-btn").click(function(event) {
      event.preventDefault();
      $("#new_question")[0].reset();
      div.slideUp();
    });
    div.slideDown();



  });

 });



 $(".index-content-link").click(function(event) {
    event.preventDefault();
    $(".index-content").hide("blind").show("blind");
    var content = $(this).attr("href");
    if (content == "/questions/list?selection=1")
      $("#current-content-on-index").html("Most recent questions");
    if (content == "/questions/list?selection=2")
      $("#current-content-on-index").html("Highest voted questions");
    if (content == "/questions/list?selection=3")
      $("#current-content-on-index").html("Trending questions");
    $.ajax({
      url: $(this).attr("href")
    }).done(function(response) {
      $(".index-content").html(response);
    }).fail(function() {



    });// $.ajax({


  }); // $(".index-content-link").click(function()

$.ajax({
      url: "/questions/list?selection=1",
      dataType: "html"
    }).done(function(response) {
      $("#current-content-on-index").html("Most recent questions");
      $(".index-content").html(response);
    }).fail(function() {



    });// $.ajax({







}); // end
