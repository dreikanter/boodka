json.array!(@budgets) do |budget|
  json.extract! budget, :id
  json.url budget_url(budget, format: :json)
end
