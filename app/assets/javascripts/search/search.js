$(function(){

  $("#q_size_id_in").attr("name", "q[size_id_in][]")
  $("#q_brand_id_in").val("")

  $("#q_category_id_in").on("change", function(){
    if ($(this).val() !== ""){
      var parent_id = $(this).val();
      $.ajax({
        url: "/api/search/select_children",
        type: "get",
        dataType: "html",
        data: {parent_id: parent_id}
      })
      .done(function(html){
        $("#select_category_children").remove()
        $("#select_category_grand_children").remove();
        $("#q_category_id_in").after(html)
      })
      .fail(function(){
      })
    }else{
      $("#select_category_children").remove();
      $("#select_category_grand_children").remove();
    }
  })

  $(document).on("change", "#select_category_children", function(){
    if ($(this).val() !== "" ){
      var children_id = $(this).val();
      $.ajax({
        url: "/api/search/select_grand_children",
        type: "get",
        dataType: "html",
        data: {children_id: children_id}
      })
      .done(function(html){
        $("#select_category_grand_children").remove();
        $("#select_category_children").after(html);
      })
      .fail(function(){
      })
    }else{
      $("#select_category_grand_children").remove();
    }
  })

  $("#q_size_id_in").on("change", function(){
    if ($(this).val() !== ""){
      var size_parent_id = $(this).val()
      $.ajax({
        url: "/api/search/select_size",
        type: "get",
        dataType: "html",
        data: {size_parent_id: size_parent_id}
      })
      .done(function(html){
        $(".size__children").remove()
        $("#q_size_id_in").after(html)
      })
      .fail(function(){
      })
    }else{
      $(".size__children").remove()
    }
  })

  $("#price__select").on("change", function(){
    if ($(this).val() === ""){
      $("#q_price_gteq").val("")
      $("#q_price_lteq").val("")
    }else if($(this).val() == 0){
      $("#q_price_gteq").val(300)
      $("#q_price_lteq").val(1000)
    }else if($(this).val() == 1){
      $("#q_price_gteq").val(1000)
      $("#q_price_lteq").val(5000)
    }else if($(this).val() == 2){
      $("#q_price_gteq").val(5000)
      $("#q_price_lteq").val(10000)
    }else if($(this).val() == 3){
      $("#q_price_gteq").val(10000)
      $("#q_price_lteq").val(30000)
    }else if($(this).val() == 4){
      $("#q_price_gteq").val(30000)
      $("#q_price_lteq").val(50000)
    }else if($(this).val() == 5){
      $("#q_price_gteq").val(50000)
      $("#q_price_lteq").val("")
    }
  })

  $(".all_check").on("click", function(){
    $(this).parent().parent().children().children().prop('checked', this.checked);
  })

  $("input[type='checkbox']").on("click", function(){
    if ($(this).parent().parent().children().children("input:checked").length >= 
        $(this).parent().parent().children().children("input").length - 1){
          $(this).parent().parent().children().children(".all_check").prop('checked', this.checked);
        }
  })

  $(".all_clear").on("click", function(){
    $(".js").remove()
  })
})