$(function(){
  $("#item_price").on("keyup", function(){
    $(".items__sell__form__price-form-commission-price").text("-")
    $(".items__sell__form__price-form-profit-price").text("-")
    var price = Number($(this).val())
    if (!isNaN(price) && 300 <= price && price <= 9999999){
      var fee = Math.floor(price * 0.1)
      var gain = price - fee
      $(".items__sell__form__price-form-commission-price").text(fee)
      $(".items__sell__form__price-form-profit-price").text(gain)
    }
  })
})