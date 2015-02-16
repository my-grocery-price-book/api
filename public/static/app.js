function update_entries() {
  $.ajax({url: "/entries.json"}).done(function (entries) {
    $('#entries').empty();
    $.each(entries, function( _i, entry ) {
      var content = '<b>' + entry.generic_name + '(' + entry.quanity_unit + ')</b>';
      content += '<table class="table">';
      content += '<thead>';
      content += "<td>Date on</td>";
      content += "<td>Store</td>";
      content += "<td>Location</td>";
      content += "<td>Brand</td>";
      content += "<td>Quanity</td>";
      content += "<td>PP</td>";
      content += '</thead>';

      content += '<tbody>';

      $.each(entry.prices, function( _j, price ) {
        var new_row = "<td>" + price.date_on + "</td>";
        new_row += "<td>" + price.store + "</td>";
        new_row += "<td>" + price.location + "</td>";
        new_row += "<td>" + price.brand + "</td>";
        new_row += "<td>" + price.quanity + "</td>";
        new_row += "<td>" + (price.total_price / price.quanity) + "</td>";
        content += '<tr>' + new_row + '</tr>';
      });
      content += '</tbody></table>';
      $('#entries').append(content);
    });
  });
}

$('#create_form').submit(function (e) {
  e.preventDefault();
  var params = $("#create_form").serialize().replace(/[^&]+=\.?(?:&|$)/g, '');
  $.post("/entries.json", params).done(function () {
    $('#create_form').trigger('reset');
    update_entries();
  }).error(function() {
    alert('Error!');
  });
});

update_entries();
