require "csv"

CSV.foreach('db/category.csv', headers: true) do |row|
  Category.create(
    id: row['id'],
    parent_id: row['parent_id'],
    name: row['name']
  )
end

