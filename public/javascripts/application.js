var default_coords = new google.maps.LatLng(-12.033333, -77.016667);
var center;
var map;

function set_map(latlng){
  map = new google.maps.Map(document.getElementById("map"), {
    zoom: 12,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
}

function load_places(){
  categories = [];
  $('#categories ul li').filter('.selected').find('a').map(function(index, item){categories.push($(item).attr('id').replace('category_', ''))});
  $.getJSON('/places.json?latlng='+center.toUrlValue()+'&cat='+categories.toString(), function(data){
    $(data).each(function(index, item){
      console.log(item);
    });
  });
}

$(document).ready(function(){
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
    if(navigator.geolocation){
      navigator.geolocation.getCurrentPosition(function(position){
        center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
      }, function(error){
        center = default_coords;
        //console.log(error);
        set_map(center);
      }, {enableHighAccuracy:true, maximumAge:30000, timeout:27000});
    }
    else{
      center = default_coords;
      set_map(center);
    }
  }
});