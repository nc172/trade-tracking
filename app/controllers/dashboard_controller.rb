class DashboardController < ApplicationController
  def index
    return unless user_signed_in?

    @trades = current_user.trades

    @total_trades = @trades.count
    @net_pnl = @trades.sum(:net_pnl)

    @wins = @trades.where(status: "win")
    @losses = @trades.where(status: "loss")

    @win_count = @wins.count
    @loss_count = @losses.count

    @win_rate =
      if @total_trades.positive?
        ((@win_count.to_f / @total_trades) * 100).round(2)
      else
        0
      end

    @average_win =
      if @win_count.positive?
        (@wins.average(:net_pnl) || 0).round(2)
      else
        0
      end

    @average_loss =
      if @loss_count.positive?
        (@losses.average(:net_pnl) || 0).round(2)
      else
        0
      end

    gross_profit = @wins.sum(:net_pnl)
    gross_loss = @losses.sum(:net_pnl).abs

    @profit_factor =
      if gross_loss.positive?
        (gross_profit / gross_loss).round(2)
      else
        0
      end
  end
end