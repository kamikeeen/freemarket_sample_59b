$(function() {
  $('.show-item').on('mouseenter', function() {
    $(this).css('outline', '1px solid #0099e8');
  }).on('mouseleave', function() {
    $(this).css('outline', '');
  });
})