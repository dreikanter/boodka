json.budget do
  json.category_id @budget.category_id
  json.year        @budget.year
  json.month       @budget.month
  json.planned     @budget.display_planned
  json.actual      @budget.display_actual
  json.balance     @budget.display_balance
  json.memo        @budget.memo
  json.created_at  @budget.created_at
  json.updated_at  @budget.updated_at
end
