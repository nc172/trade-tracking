class Import < ApplicationRecord
  belongs_to :user
  has_many :trades, dependent: :destroy

  has_one_attached :file

  validates :source_platform, presence: true
  validates :status, presence: true
end