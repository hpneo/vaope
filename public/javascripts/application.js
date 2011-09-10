function openWindow(url, name, width, height){
  centerWidth = (window.screen.width - width)/2;
  centerHeight = (window.screen.height - height)/2;
  
  newWindow = window.open(url, name, 'resize=no,toolbar=no,width=' + width + 
    ',height=' + height + 
    ',left=' + centerWidth + 
    ',top=' + centerHeight);
  
  newWindow.focus();
  return newWindow.name;
}

$(document).ready(function(){
  $('.sign_in').mouseover(function(){
    $('.auth_options').show();
  }).mouseout(function(){
    $('.auth_options').hide();
  });

  $('.share').click(function(e){
    e.preventDefault();
    $($(this).attr('href')).fadeToggle();
    $(this).toggleClass('checked');
  });

  $('#share_twitter').click(function(e){
    e.preventDefault();
    openWindow($(this).attr('href'), $(this).attr('id'), 580, 251);
  });

  $('#share_facebook').click(function(e){
    e.preventDefault();
    openWindow($(this).attr('href'), $(this).attr('id'), 580, 300);
  });
});