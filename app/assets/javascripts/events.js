$("#event_eventbrite_id").change(function(e) {
  loadEventInfo(e.target.value);
});

function loadEventInfo(eventbriteId) {
  $("#spinner").show();
  $.ajax({
    url: '/events/eventbrite.json',
    data: {
      id: eventbriteId
    },
    success: function(data, textStatus, jqXHR) {
      $('#event_title').val(data.title);
      $('#event_description').val(data.description);
      $('#event_start').val(data.start);
      $('#event_end').val(data.end);
      $('#event_latitude').val(data.latitude);
      $('#event_longitude').val(data.longitude);
      $("#spinner").hide();
    },
    error: function() {
      alert("Error loading event data");
      $("#spinner").hide();
    }
  });
}