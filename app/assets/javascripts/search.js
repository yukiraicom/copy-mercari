$(function () {
  function putCategoryOption(category) {
      var optionHtml = ""
      category.forEach(function (e) {
        optionHtml += `<option value='${e.id}'>${e.name}</option>\n`
      })
      return optionHtml
    }
    function buildCategory(category) {
      var html = `
        <select class="item-form__select-box" name="q[category_id_cont_all]" id="search_category_id" data-parent-id="${category[0].parent_id}">
          <option value="">---</option>
          ${putCategoryOption(category)}
        </select>
        <i class="fa fa-chevron-down item-form__select-icon"></i>
      `
      return html
    }

  $(document).on("change", ".item-form__select-box#search_category_id", function () {
    var thisSelecter = $(this)
    selected_number = thisSelecter.val()
    var detailSelect = thisSelecter.parents(".detailSelect")
    var previousOptions = $(this).parents(".detailSelect").find(".item-form__select-box#search_category_id")
    detailSelect.empty()
    $.ajax({
      type: "GET",
      url: '/api/item',
      data: { selected_number: selected_number }
    })
      .done(function (category) {
        var previousId = 0
        for (preselecter of previousOptions) {
          previousId = $(preselecter).val();
          if (category.length == 0) {
            detailSelect.append(preselecter)
          } else if (previousId == category[0].parent_id) {
            detailSelect.append(preselecter)
          } else if ($(preselecter).data("parent-id") == 0) {
            detailSelect.append(preselecter)
          }
        }
        if (category.length != 0) {
          detailSelect.append(buildCategory(category))
        }
      })
  })
})
