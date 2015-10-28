json.budget do
  json.category_id @budget.category_id
  json.year        @budget.year
  json.month       @budget.month
  json.amount      @budget.display_amount
  json.actual      @budget.display_spent
  json.balance     @budget.display_balance
  json.memo        @budget.memo
  json.created_at  @budget.created_at
  json.updated_at  @budget.updated_at
end
