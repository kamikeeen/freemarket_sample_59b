$(function(){
  
  function buildBrandList(brand){
    var html = `<li class="brand__result__list" data-id=${brand.id} >${brand.name}</li>`
    return html
  }

  function buildBrandNone(){
    var html = `<li class="brand__result__list" >該当するブランドはありません</li>`
    return html
  }

  $(document).on("change", "#category_grand_children", function(){
    $(".items__new__sell__form__item__detail-form__brand").css("display", "block")
  })

  $(document).on("keyup", ".brand_form", function(){
    var keyword = $(this).val();
    if ($(this).val() !== ""){
      $.ajax({
        url: "/api/brands/form",
        type: "get",
        data: { keyword: keyword },
        dataType: "json"
      })
      .done(function(brands){
        $(".brand__result__list").remove()
        if (brands.length === 0){
          $(".brand__result__lists").append(buildBrandNone())
        }else{
          $(".brand__result__list").remove()
          brands.forEach(function(brand){
            $(".brand__result__lists").append(buildBrandList(brand))
          });
        }
      })
      .fail(function(){
      })
    }else{
      $(".brand__result__list").remove()
    }
  })

  $(document).on("click", ".brand__result__list", function(){
    var get_brand_id = $(this).data("id")
    var get_brand_name = $(this).text()
    $("#item_brand_id").val(get_brand_id)
    $(".brand_form").val(get_brand_name)
    $(".brand__result__list").remove()
  })
})