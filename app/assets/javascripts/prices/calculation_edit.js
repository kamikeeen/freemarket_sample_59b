$(function(){
  $(document).ready(function(){
    $(".items__edit__sell__form__price-form-commission-price").text("-")
    $(".items__edit__sell__form__price-form-profit-price").text("-")
    var price = Number($("#item_price").val())
    if (!isNaN(price) && 300 <= price && price <= 9999999){
      var fee = Math.floor(price * 0.1)
      var gain = price - fee
      $(".items__edit__sell__form__price-form-commission-price").text(fee)
      $(".items__edit__sell__form__price-form-profit-price").text(gain)
    }
  });
  $("#item_price").on("keyup", function(){
    $(".items__edit__sell__form__price-form-commission-price").text("-")
    $(".items__edit__sell__form__price-form-profit-price").text("-")
    var price = Number($(this).val())
    if (!isNaN(price) && 300 <= price && price <= 9999999){
      var fee = Math.floor(price * 0.1)
      var gain = price - fee
      $(".items__edit__sell__form__price-form-commission-price").text(fee)
      $(".items__edit__sell__form__price-form-profit-price").text(gain)
    }
  })
})