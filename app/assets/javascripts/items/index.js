$(function() {
  $('.show-item').on('mouseenter', function() {
    // console.log("ポインターがのりました");
    $(this).css('outline', '1px solid #0099e8');
    // $(this).animate('outline', '1px solid #0099e8');
  }).on('mouseleave', function() {
    // console.log("ポインターが外れました");
    $(this).css('outline', '');
  });
})