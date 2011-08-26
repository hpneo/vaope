$(document).ready(function(){
  $('#show_map').change(function(){
    if($(this).attr('checked')){
      $('#map').slideDown('fast', function(){
        map = new GMaps({
          div:'#map',
          lat: -12.043333,
          lng: -77.028333
        });
        map.add_marker(-12.043333, -77.028333, {
          title: 'Nuevo local',
          draggable: true,
          animation: google.maps.Animation.Ek,
          dragend: function(e){
            $('#place_lat').val(e.latLng.Oa);
            $('#place_lng').val(e.latLng.Pa);
          },
          click: function(e){
            console.log(e);
          }
        });
      });
    }
    else{
     $('#map').slideUp();
    }
  });
});