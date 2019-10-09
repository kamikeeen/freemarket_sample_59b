$(function(){
  var item_id = $("#item_id").text();
  if (item_id !== ""){

    var form_width = `100%`
    for (var m = 0; m < $(".image_preview").length; m++) {
      $(`label[for=item_images_attributes_${m}_name`).css("display", "none")
      if (m < 4){
        form_width = `calc(100% - 126 * ${m + 1}px)`
      }else if(m > 4){
        form_width = `calc(100% - 126 * ${m - 4}px)`
      }else{
        form_width = `100%`
      }
      $(`label[for=item_images_attributes_${m + 1}_name`).css("width", `${form_width}`)
      $(`label[for=item_images_attributes_${m + 1}_name`).css("display", "block")
      }

    function buildHtml(num){
      var html = `<div class="image_preview">
                    <div class="image${num}" data-num="${num}">
                      <img class="image" src="">
                    </div>
                    <div class="btns">
                      <div class="btn edit">
                        編集
                      </div>
                      <div class="btn delete">
                        削除
                      </div>
                    </div>
                  </div>`
        return html
    }
  
    function buildForm(num, form_width){
      var html =  `<label for="item_images_attributes_${num}_name" style="display: block; width: ${form_width}">
                    <span>
                      ドラッグアンドドロップ
                    <br>
                      またはクリックしてファイルをアップロード
                    </span>
                    <input accept="image/*" type="file" name="item[images_attributes][${num}][name]" id="item_images_attributes_${num}_name">
                    </label>`
      return html
    }
    
    var num = $(".image_preview").length
    var form_width = `100%`
    $(".items__edit__sell__form__upload-image-form").on("change", $(`#item_images_attributes_${num}_name`), function(e){
        $(`label[for=item_images_attributes_${num}_name`).css("display", "none")
        if (num === 0){
          $(".items__edit__sell__form__upload-image-form").prepend(buildHtml(num))
        }else{
          $(".image_preview").last().after(buildHtml(num))
        }
        
        var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(`.image${num}`);
        t = this;
  
        reader.onload = (function(file) {
          return function(e) {
            $preview.empty();
            $preview.append($('<img>').attr({
              src: e.target.result,
              width: "122px",
              height: "103px",
                      class: "preview",
                      title: file.name
                  }));
                };
        })(file);
        
        reader.readAsDataURL(file);
  
        num += 1
        if (num < 5){
          form_width = `calc(100% - 126 * ${num}px)`
        }else if(num > 5){
          form_width = `calc(100% - 126 * ${num - 5}px)`
        }else{
          form_width = `100%`
        }
        $(`label[for=item_images_attributes_${num}_name`).css("width", `${form_width}`)
        $(`label[for=item_images_attributes_${num}_name`).css("display", "block")
    })
  
    $(document).on("click", ".btn.delete", function(){
      var index = $(this).parent().parent().children().first().data("num")
  
      $(this).parent().parent().remove()
      num = $(".image_preview").length
      if (num < 5){
        form_width = `calc(100% - 126 * ${num}px)`
      }else if(num > 5){
        form_width = `calc(100% - 126 * ${num - 5}px)`
      }else{
        form_width = `100%`
      }
  
      $(".items__edit__sell__form__upload-image-form label").css("display", "none")
      $(`label[for=item_images_attributes_${index}_name`).remove()
      $(`.image_preview`).each(function(i, image){
        $(image).children().attr("data-num", `${i}`)
        $(image).children().first().attr("class", `image${i}`)
      })
  
      if (num === 0){
        $(".items__edit__sell__form__upload-image-form").prepend(buildForm(num, form_width))
      }else{
        $(`.items__edit__sell__form__upload-image-form label:eq(${num - 1})`).after(buildForm(num, form_width))
      }
  
      $(".items__edit__sell__form__upload-image-form label").children("input").first().each(function(i, input){
          $(input).attr("id", `item_images_attributes_${i}_name`)
          $(input).parent().attr("for", `item_images_attributes_${i}_name`)
        })
    })
  }
})