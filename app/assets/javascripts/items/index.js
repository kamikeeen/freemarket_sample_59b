$(function() {
  $('.show-item').on('mouseenter', function() {
    $(this).css({
      outline: '1px solid #0099e8',
      transition: '0.01s'
    });
  }).on('mouseleave', function() {
    $(this).css('outline', '');
  });
  $(window).on('scroll', function() {
    $(".show-item").each(function() {
      let imgPos = $(this).offset().top;
      let scroll = $(window).scrollTop();
      let windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5) {
        $(this).addClass("fade-on");
      };
    });
  });
})