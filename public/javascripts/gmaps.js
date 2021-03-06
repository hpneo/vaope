GMaps = function(options){
  this.div = $(options.div)[0];
  this.markers = [];
  this.polygon = null;
  this.infoWindow = null;
  this.map = new google.maps.Map(this.div, {
    zoom: 14,
    center: new google.maps.LatLng(options.lat, options.lng),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  google.maps.event.addListener(this.map, 'dragend', function(e){
    if(options.dragend)
      options.dragend(e);
  });
  google.maps.event.addListener(this.map, 'click', function(e){
    if(options.click)
      options.click(e);
  });
  
  this.geolocate = function(options){
    if(navigator.geolocation){
      navigator.geolocation.getCurrentPosition(function(position){
        options.success(position);
        options.always();
      }, function(error){
        options.error(error);
        options.always();
      }, options.options);
    }
    else{
      options.not_supported();
      options.always();
    }
  }

  this.set_center = function(lat, lng, callback){
    this.map.setCenter(new google.maps.LatLng(lat, lng));
    if(callback)
      callback();
  };
  this.get_center = function(){
    return this.map.getCenter();
  };
  this.add_marker = function(lat, lng, options){
    var self = this;
    var marker_options = $.extend({
      position: new google.maps.LatLng(lat, lng),
      map: this.map
    }, options);
    
    var marker = new google.maps.Marker(marker_options);
    if(options.infoWindow)
      marker.infoWindow = new google.maps.InfoWindow(options.infoWindow);

    google.maps.event.addListener(marker, 'click', function(e){
      if(options.click)
        options.click(e);
      if(marker.infoWindow){
        self.hide_info_windows();
        marker.infoWindow.open(self.map, marker);
      }
    });
    google.maps.event.addListener(marker, 'dragend', function(e){
      if(options.dragend)
        options.dragend(e);
    });

    this.markers.push(marker);
  };
  this.hide_info_windows = function(){
    for(index in this.markers){
      marker = this.markers[index];
      marker.infoWindow.close();
    }
  }
  this.remove_markers = function(){
    for(index in this.markers){
      marker = this.markers[index];
      marker.setMap(null);
    }
    this.markers = [];
  };

  this.draw_circle = function(){
    if(this.polygon)
      this.polygon.setMap(null);
    this.polygon = new google.maps.Circle({
      map: this.map,
      center: this.get_center(),
      radius: 1500,
      strokeColor: '#7ba5e4',
      fillColor: '#d8e5f7',
      strokeWeight: 2
    });
  };
}