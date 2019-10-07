$(function() {
  ArrayuploadedImages = []; //formに入れたれた画像

  function putCategoryOption(category) {
    var optionHtml = ""
      category.forEach(function(e){
        optionHtml += `<option value='${e.id}'>${e.name}</option>\n`
      })
    return optionHtml
  }
  function buildCategory(category){
    var html = `
      <div class="item-form__dev" data-parent-id="${category[0].parent_id}">
        <div class="item-form__select-wrap">
          <select class="item-form__select-box" name="item[category_id]" id="item_category_id">
            <option value="">---</option>
            ${putCategoryOption(category)}
          </select>
          <i class="fa fa-chevron-down item-form__select-icon"></i>
        </div>
      </div>
    `
    return html
  }

  $(document).on("change", ".item-form__select-box#item_category_id", function(){
    var thisSelecter = $(this)
    selected_number = thisSelecter.val()
    var itemFormDev = $(".item-form__dev#categoty")
    var itemFormGroup = thisSelecter.parent().parent().parent()
    var previousOptions = itemFormGroup.find(".item-form__dev")
    var optionsParentId = itemFormDev.data("parent-id")
    itemFormGroup.empty()
    itemFormGroup.append("<label>カテゴリー</label>")
    itemFormGroup.append("<span class='form-require'>必須</span>")

    $.ajax({
      type: "GET",
      url: '/api/item',
      data: {selected_number: selected_number}
    })
      .done(function(category){
        var previousId = 0
        previousOptions.each(function(i, option){
          if($(option).data("parent-id") == 0 || $(option).data("parent-id") == previousId ){
            itemFormGroup.append($(option))
            previousId = $(option).find('.item-form__select-box#item_category_id').val()
          }
        })
        if(category.length != 0) itemFormGroup.append(buildCategory(category))
      })
  })
})


//以下 画像サムネ生成
$(function() {
  // $('dropbox--container__dropbox__file').after('<span></span>');
  function buildImg(imgSrc, lastModified) {
    var html = `
      <li>
        <img src="${imgSrc}">
        <div class="dropbox--container__items__edit", data-lastmodified = "${lastModified}">
            <a href="">削除</a>
          </div>
      </li>
    `
    return html
  }

  $('.dropbox--container__dropbox__file').change(function() {
    // $('span').html('');
    var file = $(this).prop('files');

    var img_count = 1;
    $(file).each(function(i) {
      if (img_count > 10) {
        return false;
      }

      if (! file[i].type.match('image.*')) {
        $(this).val('');
        $('span').html('');
        return;
      }

      var reader = new FileReader();
      reader.onload = function() {
        // $('.dropbox--container__items ul li').append(img_src).append(editOrDeleteButton);
        $('.dropbox--container__items ul').append(buildImg(reader.result, file[i].lastModified))
      }
      reader.readAsDataURL(file[i]);
      // console.log(file[i].lastModified)
        //サムネ削除のためのformdata生成
      // if (typeof ArrayuploadedImages === 'undefined' || ArrayuploadedImages.length === 0 ){
      //   ArrayuploadedImages = Array.from($(this).parents(".dropbox--container").find(".dropbox--container__dropbox__file")[0].files);
      // }   
      ArrayuploadedImages.push(file[i])
      img_count = img_count + 1;
    });
  });
});

//以下　サムネからfile削除
$(function() {
  $(document).on("click", ".dropbox--container__items__edit a", function(e){
    e.preventDefault();
    var imageOfInput = $(this).parents(".dropbox--container").find(".dropbox--container__dropbox__file")
    var clickedImageLastModified = $(this).parents().data("lastmodified");

    for(var i in ArrayuploadedImages){
      if(ArrayuploadedImages[i].lastModified === clickedImageLastModified){
        ArrayuploadedImages.splice(i, 1)
      }
    }

    var formData = new FormData($(this).parents(".inner__item-form")[0]); //画像だけ空のformdatam

  
    formData.delete("item[image][image][]")

    
    for(var i in ArrayuploadedImages){
      console.log(ArrayuploadedImages[i])
      formData.append("item[image][image][]", ArrayuploadedImages[i])
    }


    //サムネを消す
    $(this).parents(".dropbox--container__items ul li").remove();
  })
})
