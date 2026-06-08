class Import < ApplicationRecord
  belongs_to :user
  has_many :trades, dependent: :destroy

  validates :source_platform, presence: true
  validates :status, presence: true
end