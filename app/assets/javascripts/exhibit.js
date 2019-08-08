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
      <div class="item-form__dev">
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

  $(".item-form__group").change(function(){
    var thisSelecter = $(this)
    var selected_category = $(".item-form__select-box#item_category_id")
    console.log(thisSelecter)
    $.ajax({
      type: "GET",
      url: '/api/item',
      data: {selected_number: selected_category[selected_category.length -1].value}
    })
      .done(function(category){
        thisSelecter.append(buildCategory(category))
      })
  })
})

