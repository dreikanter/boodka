json.budget_categories do
  json.array! @budget_categories do |item|
    json.category_id item.category_id
    json.planned     item.planned.to_f
    json.memo        item.memo
    json.created_at  item.created_at
    json.updated_at  item.updated_at
    json.cell_id     cell_id('planned', item.year, item.month, item.category_id)
  end
end
