class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :import

  validates :symbol, presence: true
  validates :side, presence: true
  validates :quantity, presence: true
  validates :net_pnl, presence: true
end