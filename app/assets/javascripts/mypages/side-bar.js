$(function() {
    //マウスを乗せたら発動
  $('.myside-bar-nav-list-item').hover(function() {
    //マウスを乗せたら色が変わる
    $(this).css('background', '#E5E5E5');
    //ここにはマウスを離したときの動作を記述
  }, function() {
    //色指定を空欄にすれば元の色に戻る
    $(this).css('background', '');
  });
});
