$(function () {
  ArrayuploadedImages = [];
  DeleteImageList = [];

  function putCategoryOption(category) {
    var optionHtml = ""
    category.forEach(function (e) {
      optionHtml += `<option value='${e.id}'>${e.name}</option>\n`
    })
    return optionHtml
  }
  function buildCategory(category) {
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

  $(document).on("change", ".item-form__select-box#item_category_id", function () {
    var thisSelecter = $(this)
    var selectedItemFormDiv = thisSelecter.parents(".item-form__dev")
    selected_number = thisSelecter.val()
    var itemFormDev = $(".item-form__dev#categoty")
    var itemFormGroup = thisSelecter.parents(".item-form__group")
    var previousOptions = itemFormGroup.find(".item-form__dev")
    var optionsParentId = itemFormDev.data("parent-id")
    itemFormGroup.empty().append("<label>カテゴリー</label><span class='form-require'>必須</span>")

    $.ajax({
      type: "GET",
      url: '/api/item',
      data: { selected_number: selected_number }
    })
      .done(function (category) {
        var previousId = 0
        for (preselecter of previousOptions) {
          previousId = $(preselecter).find('.item-form__select-box#item_category_id').val()
          if (category.length == 0) {
            itemFormGroup.append(preselecter)
          } else if (previousId == category[0].parent_id) {
            itemFormGroup.append(preselecter)
          } else if ($(preselecter).data("parent-id") == 0) {
            itemFormGroup.append(preselecter)
          }
        }
        if (category.length != 0) {
          itemFormGroup.append(buildCategory(category))
        }
      })
  })
})


//以下 画像サムネ生成
$(function () {
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

  $('.dropbox--container__dropbox__file').change(function () {
    var file = $(this).prop('files');
    var img_count = 1;
    $(file).each(function (i) {
      if (!file[i].type.match('image.*')) {
        return;
      }
      var reader = new FileReader();
      reader.onload = function () {
        $('.dropbox--container__items ul').append(buildImg(reader.result, file[i].lastModified))
      }
      reader.readAsDataURL(file[i]);
      ArrayuploadedImages.push(file[i])
      img_count = img_count + 1;
    });
  });
});

//以下　サムネからfile削除
$(function () {
  $(document).on("click", ".dropbox--container__items__edit a", function (e) {
    e.preventDefault();
    var clickedImageLastModified = $(this).parents().data("lastmodified");
    for (var i in ArrayuploadedImages) {
      if (ArrayuploadedImages[i].lastModified === clickedImageLastModified) {
        ArrayuploadedImages.splice(i, 1)
      }
    }
    //サムネを消す
    $(this).parents(".dropbox--container__items ul li").remove();

    //updateアクションでdbから弾くリスト
    DeleteImageList.push($(this).parents("li").data("id"));
  })
})

$(function () {
  $(".inner__item-form").on("submit", function (e) {
    e.preventDefault();
    var formData = new FormData($(this)[0]);
    formData.delete("item[image][image][]")
    for (var i in ArrayuploadedImages) {
      formData.append("item[image][image][]", ArrayuploadedImages[i])
    }

    for (var i in DeleteImageList) {
      formData.append("deleteImageList[]", DeleteImageList[i])
    }

    if(window.location.pathname.match(/\/items\/new/)){
      $.ajax({
        type: "POST",
        url: "/items",
        data: formData,
        dataType: "json",
        cache    : false,
        processData: false,
        contentType: false
      })
        .done(function (status) {
          if (status.status === "ok") {
            window.location.href = "/"
          }
        })
        .fail(function () {
          $("form").unbind('submit').submit()
        })
    } else {
      url = "/items/"+ parseInt(window.location.pathname.match(/\d+/))
      formData.append("itemId", parseInt(window.location.pathname.match(/\d+/)))
      $.ajax({
        type: "PATCH",
        url: url,
        data: formData,
        dataType: "json",
        processData: false,
        contentType: false
      })
        .done(function (status) {
          if (status.status === "ok") {
            window.location.href = "/"
          }
        })
        .fail(function () {
          $("form").unbind('submit').submit()
        })
    }
  })
})

$(function () {
  $(document).on("input", "#item_price", function () {
    var inputValue = parseInt($(this).val());
    if (inputValue >= 300) {
      var fee = parseInt(inputValue * 0.1)
      var profit = inputValue - fee
      var parentOfThis = $(this).parents(".item-form__group")
      var feeText = parentOfThis.find(".item-form__price--r").eq(1)
      feeText.empty().append("¥" + fee)
      var profitText = parentOfThis.find(".item-form__price--r").eq(2)
      profitText.empty().append("¥" + profit)
    }
  })
})