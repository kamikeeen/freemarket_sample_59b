$(function() {
  $('a[href^="#"]').click(function() {
    let speed = 400;
    let href = $(this).attr('href');
    let target = $(href == "#" || href == "" ? 'html' : href);
    let position = target.offset().top;

    $('body, html').animate({scrollTop:position}, speed, 'swing');

    return false;
  });
});