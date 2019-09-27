$(function(){

  var notificationTabs = $(".notification__tabs .tab")
  var transactionTabs = $(".transaction__tabs .tab")

  function notificationTabSwitch() {
    $(".notification__tabs .active").removeClass("active");
    $(this).addClass("active")
    const index = notificationTabs.index(this);
    $(".notification__contents .box__content ").removeClass("show").eq(index).addClass("show");
  }

  function transactionTabSwitch() {
    $(".transaction__tabs .active").removeClass("active");
    $(this).addClass("active")
    const index = transactionTabs.index(this);
    $(".transaction__contents .box__content ").removeClass("show").eq(index).addClass("show");
  }


  notificationTabs.click(notificationTabSwitch);
  transactionTabs.click(transactionTabSwitch);


})