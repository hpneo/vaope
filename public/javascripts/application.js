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
});