$(document).ready(function () {

  // send an HTTP DELETE request for the sign-out link
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();

    var url = $(this).attr("href")
    $.ajax({
      type: "delete",
      url: url
    }).done(function () { window.location = "/"; });
  });

  // create new owner and display error messages with ajax
  $('form#owner_sign_up').on("submit", function (e) {
    e.preventDefault();

    var url = $(this).attr('action');
    var data = $(this).serialize();
    var that = $(this)
    $.ajax({
      type: 'post',
      url: url,
      data: data
    }).done(function(response) {
      if(response.error) {
        $(that).append('<h3 style="color:red">'+response.message+'</h3>')
      }
      else {
        window.location = "/"
      }
    })
  })

});
