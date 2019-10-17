$(function() {
  $('.picture__m').eq(0).css("display", "block");
  //マウスを乗せたら発動
  $('.picture').hover(function() {
    $('.picture__m').css("display", "none");
    var index = $('.picture').index(this);
    $('.picture__m').eq(index).css("display", "block");
  });
});