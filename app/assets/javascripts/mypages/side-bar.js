$(function() {
    //マウスを乗せたら発動
  $('a.myside-bar-nav-list-item').hover(function() {
    //マウスを乗せたら色が変わる
    $(this).css('background', '#c00');
    //ここにはマウスを離したときの動作を記述
  }, function() {
    //色指定を空欄にすれば元の色に戻る
    $(this).css('background', '');
  });
  $('a.myside-bar-nav-list-item').hover(function() {
    //上で取得した.hoverのデータを.childrenを使って対象を子要素にしてる
      $(this).children();
      test1 = $(this).children();
      $(test1).css({
        'border': '1px solid #00ffff'
      });
  }, function() {
    //指定の要素をを空欄にして元に戻す
    $(this).children().css('border', '');
  });
});


// });
// $(this).css('transform-translate', '');
// // $(this).css('transform: translateX', '60%');
// $('.myside-bar-nav-list-item .fa-angle-right').css('border', '1px solid #00ffff');この記述だと全ての矢印が対象になってしまう。
// $(this).children().css('border', '1px solid #00ffff');
// return value > 1;
// $(test2).css({'transform-translateX':'60%', });
// var test2 = test1.filter( function( value ) {
// console.log(test1)
// $(test1).css({'border': '1px solid #00ffff'});