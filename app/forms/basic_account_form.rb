class BasicAccountForm < Reform::Form
  property :title, on: :account
  property :memo, on: :account
  property :currency, on: :account
  property :default, on: :account

  validates :title, :currency, presence: true
end
