function add_marker(){
  map.add_marker(map.get_center().lat(), map.get_center().lng(), {
    title: 'Nuevo local',
    draggable: true,
    animation: google.maps.Animation.Ek,
    dragend: function(e){
      $('#place_lat').val(e.latLng.lat());
      $('#place_lng').val(e.latLng.lng());
    },
    click: function(e){
      console.log(e);
    }
  });
}

function marker_to_input(){
  $('#place_lat').val(map.markers[0].position.lat());
  $('#place_lng').val(map.markers[0].position.lng());
}

$(document).ready(function(){
  $('#show_map').change(function(){
    if($(this).attr('checked')){
      $('#map').slideDown('fast', function(){
        map = new GMaps({
          div:'#map',
          lat: -12.043333,
          lng: -77.028333
        });
        if($('#place_lat').val()=='' || $('#place_lng').val()==''){
          map.geolocate({
            success: function(position){
              map.set_center(position.coords.latitude, position.coords.longitude);
            },
            error: function(error){
              map.set_center(-12.043333, -77.028333);
            },
            not_supported: function(){
              map.set_center(-12.043333, -77.028333);
            },
            always: function(){
              add_marker();
              marker_to_input();
            },
            options: {enableHighAccuracy:true, maximumAge:30000, timeout:27000}
          });
        }
        else{
          map.set_center($('#place_lat').val(), $('#place_lng').val(), function(){
            add_marker();
          });
        }
      });
    }
    else{
     $('#map').slideUp();
     $('#place_lat').val('');
     $('#place_lng').val('');
    }
  });
  $('#show_map').attr('checked', true).trigger('change');
});