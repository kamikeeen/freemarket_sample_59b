$(function(){
  var logoutbutton = $(".mypage__logout__button input")

  logoutbutton.on('click',function(){
    $(this).css('background-color','gray');
  })
})