$(document).ready(function() {

 $(".index-content-link").click(function(event) {
    event.preventDefault();
    $(".index-content").hide("blind").show("blind");

    $.ajax({
      url: $(this).attr("href"),
      dataType: "html"
    }).done(function(response) {
      $(".index-content").html(response);
    }).fail(function() {



    });// $.ajax({


  }); // $(".index-content-link").click(function()

$.ajax({
      url: "/questions/list?selection=1",
      dataType: "html"
    }).done(function(response) {
      $(".index-content").html(response);
    }).fail(function() {



    });// $.ajax({







}); // end
