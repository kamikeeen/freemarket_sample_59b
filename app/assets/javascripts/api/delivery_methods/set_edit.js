$(function(){
  $(document).ready(function(){
    var item_id = $("#item_id").text();
    $.ajax({
      url: "/api/delivery_methods/set",
      type: "get",
      data: { item_id: item_id },
      dataType: "html"
    })
    .done(function(html){
      $(".items__edit__sell__form__about-delivery-form__delivery_method").remove();
      $(".items__edit__sell__form__about-delivery-form__post-area").before(html)
    })
    .fail(function(){
    })
  });
  $("#item_postage_side").on("change", function(){
    if ($(this).val() !== ""){
      var postage_side = $(this).val();

      $.ajax({
        url: "/api/delivery_methods/select",
        type: "get",
        data: { postage_side: postage_side},
        dataType: "html"
      })
      .done(function(html){
        $(".items__edit__sell__form__about-delivery-form__delivery_method").remove();
        $(".items__edit__sell__form__about-delivery-form__post-area").before(html)
      })
      .fail(function(){
      })
    }else{
      $(".items__edit__sell__form__about-delivery-form__delivery_method").remove();
    }
  })
})