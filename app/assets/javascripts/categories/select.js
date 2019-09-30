$(function(){

  $("#category_parent").on("change", function(){
    if ($(this).val() !== ""){
      var parent_id = $(this).val();
      $.ajax({
        url: "/api/categories/select_children",
        type: "get",
        dataType: "html",
        data: {parent_id: parent_id}
      })
      .done(function(html){
        $("#category_children").remove();
        $("#category_grand_children").remove();
        $("#size_id").remove();
        $(".items__new__sell__form__item__detail-form__category").append(html);
      })
      .fail(function(){
      })
    }else{
      $("#category_children").remove();
      $("#category_grand_children").remove();
      $("#size_id").remove();

    }
  })

  $(document).on("change", "#category_children", function(){
    if (($(this).val() !== "" ) && ($(this).val() !== "1234" ) && ($(this).val() !== "1325" )){
      var children_id = $(this).val();
      $.ajax({
        url: "/api/categories/select_grand_children",
        type: "get",
        dataType: "html",
        data: {children_id: children_id}
      })
      .done(function(html){
        $("#category_grand_children").remove();
        $(".items__new__sell__form__item__detail-form__category").append(html);
        $("#size_id").remove();
      })
      .fail(function(){
      })
    }else{
      $("#category_grand_children").remove();
      $("#size_id").remove();
    }
  })
  
  $(document).on("change", "#category_grand_children", function(){
    var grand_child_size_id = $("#category_grand_children option:selected").data("size-id")
    var child_size_id = $("#category_children option:selected").data("size-id")
    if (grand_child_size_id || child_size_id){
      var size_id = (grand_child_size_id) ? grand_child_size_id : child_size_id
      $.ajax({
        url: "/api/sizes/select",
        type: "get",
        data: { size_id: size_id },
        dataType: "html"
      })
      .done(function(html){
        $("#size_id").remove();
        $(".items__new__sell__form__item__detail-form__status").before(html);
      })
    }else{
      $("#size_id").remove();
    }
  })
})