json.budget_category do
  json.category_id @budget_category.category_id
  json.planned     @budget_category.planned.to_f
  json.memo        @budget_category.memo
  json.created_at  @budget_category.created_at
  json.updated_at  @budget_category.updated_at
end
