class Import < ApplicationRecord
  belongs_to :user
  has_many :trades, dependent: :destroy

  has_one_attached :file

  validates :source_platform, presence: true
  validates :status, presence: true

  def summary_text
    "#{created_trades_count} created, #{skipped_duplicates_count} skipped, #{failed_rows_count} failed"
  end
end