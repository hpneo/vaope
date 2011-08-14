$(document).ready(function(){
  $('#show_map').change(function(){
    if($(this).attr('checked')){
     $('#map').slideDown('fast', function(){
       map = new GMaps('#map', -12.043333, -77.028333);
       map.add_marker(-12.043333, -77.028333, '');
     });
    }
    else{
     $('#map').slideUp();
    }
  });
});