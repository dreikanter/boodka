# == Schema Information
#
# Table name: transactions
#
#  id                         :integer          not null, primary key
#  account_id                 :integer          not null
#  direction                  :integer          default(0), not null
#  amount_cents               :integer          default(0), not null
#  amount_currency            :string           default("USD"), not null
#  calculated_amount_cents    :integer          default(0), not null
#  calculated_amount_currency :string           default("USD"), not null
#  rate                       :float            default(1.0), not null
#  category_id                :integer
#  transfer_id                :integer
#  memo                       :string           default(""), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Transaction < ActiveRecord::Base
  monetize :amount_cents,
           with_model_currency: :amount_cents_currency

  monetize :calculated_amount_cents,
           with_model_currency: :calculated_amount_currency

  validates :amount_cents, numericality: { greater_than: 0 }

  validates :amount_currency,
            :calculated_amount_currency,
            inclusion: { in: Const::CURRENCY_CODES }

  validates :account_id, :direction, presence: true

  enum direction: Const::TRANSACTION_DIRECTIONS

  belongs_to :category
  belongs_to :account
  belongs_to :transfer

  scope :with_account, -> { includes(:account) }
  scope :history, -> { with_account.order('created_at desc') }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }
  scope :outflows, -> { where(direction: Const::OUTFLOW) }
  scope :inflows, -> { where(direction: Const::INFLOW) }
  scope :expenses, -> { outflows.where(transfer_id: nil) }

  before_save :calculate_amount
  after_save :update_budget
  after_destroy :update_budget

  delegate :currency, to: :account, prefix: :account

  def transfer?
    transfer_id.present?
  end

  private

  def calculate_amount
    refresh_rate if new_record? || amount_currency_changed?
    Log.debug 'refresh_calculated_amount'
    self.calculated_amount_cents = Integer(amount_cents * rate)
  end

  def refresh_rate
    Log.debug 'refresh_rate'
    self.calculated_amount_currency = account_currency
    self.rate = (amount_currency == account_currency) ? 1 : load_rate
  end

  def refresh_rate_if_currency_changed
    refresh_rate if amount_currency_changed?
  end

  def load_rate
    Log.info "loading rate #{amount_currency}-#{account_currency}"
    Money.default_bank.get_rate(amount_currency, calculated_amount_currency)
  end

  def update_budget
    budget_keys_to_refresh.each { |key| Budget.refresh!(key) }
  end

  def budget_keys_to_refresh
    [previous_budget_key, current_budget_key].compact.uniq
  end

  def budget_key(created_at, category_id)
    {
      year: created_at.year,
      month: created_at.month,
      category_id: category_id
    }
  rescue
    nil
  end

  def current_budget_key
    budget_key(created_at, category_id) if outflow?
  end

  def previous_budget_key
    present = !new_record? && (direction_was == 'outflow')
    budget_key(created_at_was, category_id_was) if present
  end
end
