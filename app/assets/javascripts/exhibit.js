$(function() {
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

