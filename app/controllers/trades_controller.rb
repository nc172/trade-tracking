class TradesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trade, only: [:show, :update]

  def index
    @trades = current_user.trades.order(entry_time: :desc)
  end

  def show
  end

  def update
    if @trade.update(trade_review_params)
      redirect_to @trade, notice: "Trade review saved."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_trade
    @trade = current_user.trades.find(params[:id])
  end

  def trade_review_params
    params.require(:trade).permit(
      :setup_type,
      :mistake_type,
      :emotion,
      :plan_adherence,
      :confidence_rating,
      :review_note
    )
  end
end