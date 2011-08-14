GMaps = function(div_id, lat, lng){
  this.div = $(div_id)[0];
  this.markers = [];
  this.map = new google.maps.Map(this.div, {
    zoom: 12,
    center: new google.maps.LatLng(lat, lng),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  
  this.set_center = function(lat, lng){
    this.map.setCenter(new google.maps.LatLng(lat, lng));
  };
  this.add_marker = function(lat, lng, title){
    this.markers.push(new google.maps.Marker({
      position: new google.maps.LatLng(lat, lng),
      map: this.map,
      title: title
    }));
  };
  this.remove_markers = function(){
    for(index in this.markers){
      marker = this.markers[index];
      marker.setMap(null);
    }
    this.markers = [];
  };
}