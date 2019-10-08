$(function(){
  $(".item-detail__contents__inner__details__confirm-delete-item").on("click", function(e) {
    e.preventDefault();
    console.log(this)
    $(".item-delete-confimation-popup").addClass("active")
  })
})