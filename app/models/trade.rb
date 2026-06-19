class Trade < ApplicationRecord
  SETUP_TYPES = {
    "breakout" => "Breakout",
    "reversal" => "Reversal",
    "pullback" => "Pullback",
    "trend_continuation" => "Trend Continuation",
    "support_resistance" => "Support / Resistance",
    "news_volatility" => "News / Volatility",
    "other" => "Other"
  }.freeze

  MISTAKE_TYPES = {
    "none" => "None",
    "chased" => "Chased",
    "late_entry" => "Late Entry",
    "early_exit" => "Early Exit",
    "moved_stop" => "Moved Stop",
    "overtrading" => "Overtrading",
    "revenge_trade" => "Revenge Trade",
    "oversized" => "Oversized",
    "ignored_plan" => "Ignored Plan"
  }.freeze

  EMOTIONS = {
    "calm" => "Calm",
    "confident" => "Confident",
    "fearful" => "Fearful",
    "greedy" => "Greedy",
    "frustrated" => "Frustrated",
    "tired" => "Tired",
    "tilted" => "Tilted"
  }.freeze

  PLAN_ADHERENCE_OPTIONS = {
    "followed_plan" => "Followed Plan",
    "mostly_followed" => "Mostly Followed",
    "broke_plan" => "Broke Plan",
    "no_plan" => "No Plan"
  }.freeze

  belongs_to :user
  belongs_to :import

  validates :symbol, presence: true
  validates :side, presence: true
  validates :quantity, presence: true
  validates :net_pnl, presence: true

  validates :buy_fill_id,
            uniqueness: {
              scope: [:user_id, :sell_fill_id],
              allow_blank: true
            }

  validates :setup_type, inclusion: { in: SETUP_TYPES.keys }, allow_blank: true
  validates :mistake_type, inclusion: { in: MISTAKE_TYPES.keys }, allow_blank: true
  validates :emotion, inclusion: { in: EMOTIONS.keys }, allow_blank: true
  validates :plan_adherence, inclusion: { in: PLAN_ADHERENCE_OPTIONS.keys }, allow_blank: true
  validates :confidence_rating, inclusion: { in: 1..5 }, allow_blank: true

  def win?
    status == "win"
  end

  def loss?
    status == "loss"
  end

  def breakeven?
    status == "breakeven"
  end

  def setup_type_label
    SETUP_TYPES[setup_type]
  end

  def mistake_type_label
    MISTAKE_TYPES[mistake_type]
  end

  def emotion_label
    EMOTIONS[emotion]
  end

  def plan_adherence_label
    PLAN_ADHERENCE_OPTIONS[plan_adherence]
  end
end