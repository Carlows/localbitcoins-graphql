class Publication < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :currency, presence: true, inclusion: { in: %w(BTC USD), message: "%{value} is not a valid currency" }
end
