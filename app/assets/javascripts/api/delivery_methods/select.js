$(function(){
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
        $(".items__sell__form__about-delivery-form__delivery_method").remove();
        $(".items__sell__form__about-delivery-form__post-area").before(html)
      })
      .fail(function(){
      })
    }else{
      $(".items__sell__form__about-delivery-form__delivery_method").remove();
    }
  })
})