class Transaction < ApplicationRecord
  belongs_to :user

  validates :transaction_type, inclusion: { in: %w(debit credit), message: "%{value} is not a valid transaction type" }, presence: true
  validates :currency, inclusion: { in: %w(BTC USD), message: "%{value} is not a valid currency" }, presence: true
  validates :amount, presence: true
end
