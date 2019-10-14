$(function(){
  $(".item-detail__contents__inner__details__confirm-delete-item").on("click", function(e) {
    e.preventDefault();
    $("#item-delete-confimation-popup").addClass("active");
  })
  $(".content__lower").on("click", ".content__lower--cancel" , function(e) {
    e.preventDefault();
    $("#item-delete-confimation-popup").removeClass("active");
  })
})