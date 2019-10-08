$(function(){
  $(".item-delete-popup").on("click", function(e) {
    e.preventDefault();
    console.log(this)
    $(".item-delete-confimation-popup").addClass("active")
  })
})