class Category < ActiveRecord::Base
  validates :title, presence: true

  has_many :transaction, dependent: :nullify
  has_many :planned_transactions, dependent: :nullify
end
