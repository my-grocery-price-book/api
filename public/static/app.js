$('#create_form').submit(function (e) {
  e.preventDefault();
  var params = $("#create_form").serialize().replace(/[^&]+=\.?(?:&|$)/g, '');
  $.post("/entries.json", params).done(function () {
    $('#create_form').trigger('reset');
    $.ajax({url: "/entries.json"}).done(function (entries) {

    });
  }).error(function() {
    alert('Error!');
  });
});


$.ajax({url: "/entries.json"}).done(function (entries) {

});
