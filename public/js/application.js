$(document).ready(function () {

  // send an HTTP DELETE request for the sign-out link
  $('#new-walk').on("submit", function(e){
    e.preventDefault();
    var url = $(this).attr('action')
    var data = $(this).serialize()

    navigator.geolocation.getCurrentPosition(function(position){

      $.ajax({
        type: 'post',
        url: url+'?lat='+position.coords.latitude+'&lng='+position.coords.longitude,
        data: data
          }).done(function(response){
        console.log(response)
        $("#no-walk-container").empty();
        $("#no-walk-container").append(response);
        })
    })

  })

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
  });

  //display form for adding new dog
  click = 0
  $('#add_dog').on('click', function(e) {
    e.preventDefault();

    var that = $(this)
    var url = $(this).attr('href')
    $.ajax({
      type: 'get',
      url: url
    }).done(function(response){
      click++;
      if (click < 2) {
        $('div#form-container').append(response);
      }
    });
  })

  //submit new dog to database
  $('div#form-container').on('submit', '#new-dog-form', function (e){
    e.preventDefault();

    var that = $(this)
    var url = $(this).attr('action')
    var data = $(this).serialize()

    $.ajax({
      type: 'post',
      url: url,
      data: data
    }).done(function(response){
      console.log("iimmm here")
      $('ul#dogs').append("<li><a href=/owners/"+response.owner_id+"/dogs/"+response.dog_id+"/edit>"+response.name+"</a></li>"),
      $(that).remove();
      if ($('#dog-title').text() != "") {
        $('#dog-title').text("Your have a new Dog!")
      };
      click = 0;
    })
  })

  //display form for updating dog information
  $('ul#dogs').on('click', 'a#edit', function(e) {
    e.preventDefault();

    var click_dog = $(this)
    var url = $(this).attr('href')
    $.ajax({
      type: 'get',
      url: url
    }).done(function(response){
      click++;
      if (click < 2) {
        $('div#form-container').append(response);
      }
    });
  })

  //save new dog information in the database
  $('div#form-container').on('submit', '#edit-dog-form', function(e){
    e.preventDefault();

    var that = $(this)
    var data = $(this).serialize()
    var url = $(this).attr('action')

    $.ajax({
      type: 'put',
      url: url,
      data: data
    }).done(function(response) {
      var length = $('ul#dogs li').length
      for (var i = 0; i<length; i++) {
        var a = $('ul#dogs li a')[i]
        if ($(a).attr("href") === "/owners/"+response.id+"/dogs/"+response.dog_id+"/edit") {
          $(a).text(response.name)
        }
        $(that).remove()
        click = 0
      }
    })
  })

});
