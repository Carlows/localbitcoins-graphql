class User < ApplicationRecord
  attr_accessor :account_balance_btc
  attr_accessor :account_balance_usd

  has_secure_password

  has_many :transactions
  has_many :publications

  validates :password, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def to_token_payload
    { sub: id, email: email}
  end

  def generate_auth_token
    Knock::AuthToken.new(payload: to_token_payload).token
  end

  def account_balance_BTC
    @account_balance_btc ||= calculate_balance('BTC')
  end

  def account_balance_USD
    @account_balance_usd ||= calculate_balance('USD')
  end

  private

  def calculate_balance(currency)
    credit_transactions = transactions.where(currency: currency, transaction_type: 'credit').sum(:amount)
    debit_transactions = transactions.where(currency: currency, transaction_type: 'debit').sum(:amount)
    
    credit_transactions - debit_transactions
  end
end
