var map;
function load_places(){
  categories = [];
  map.remove_markers();
  $('#categories ul li').filter('.selected').find('a').map(function(index, item){categories.push($(item).attr('id').replace('category_', ''))});
  if(categories.length>0){
    $.getJSON('/places.json?latlng='+map.get_center().toUrlValue()+'&cat='+categories.toString(), function(data){
      $(data).each(function(index, item){
        if(item.lat && item.lng){
          map.add_marker(item.lat, item.lng, {
            title: item.name,
            animation: google.maps.Animation.DROP,
            infoWindow: {
              content: '<h2><a href="/places/'+item.id+'">'+item.name+'</a></h2position>'
            }
          });
        }
      });
    });
  }
}

$(document).ready(function(){
  map = new GMaps({
    div:'#map',
    lat: -12.043333,
    lng: -77.028333,
    dragend: function(){
      map.draw_circle();
      load_places();
    },
    click: function(e){
      console.log(e.latLng.lat());
      console.log(e.latLng.lng());
      map.set_center(e.latLng.lat(), e.latLng.lng(), function(){
        map.draw_circle();
        load_places();
      });
    }
  });

  $('#categories h4').click(function(){
    $(this).next().children().toggleClass('selected');
    load_places();
  });
  $('#categories ul li a').click(function(e){
    e.preventDefault();
    $(this).parent().toggleClass('selected');
    load_places();
  });
  if($('#map').length>0){
    map.geolocate({
      success: function(position){
        map.set_center(position.coords.latitude, position.coords.longitude);
      },
      error: function(error){
        map.set_center(-12.033333, -77.016667);
      },
      not_supported: function(){
        map.set_center(-12.033333, -77.016667);
      },
      always: function(){
        map.draw_circle();
      },
      options: {enableHighAccuracy:true, maximumAge:30000, timeout:27000}
    });
  }
});