json.array! @sub_category do |category|
  json.id category.id
  json.name category.name
  json.parent_id category.parent_id
end
