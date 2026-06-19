class DashboardController < ApplicationController
  def index
    return unless user_signed_in?

    @selected_range = params[:range].presence || "30d"

    @all_trades = current_user.trades
    @trades = filtered_trades(@all_trades, @selected_range)

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

    @equity_curve = build_daily_equity_curve(@trades)
    @daily_pnl = @trades.group_by_day(:exit_time).sum(:net_pnl)
    @win_loss_chart = {
      "Wins" => @win_count,
      "Losses" => @loss_count
    }
  end

  private

  def filtered_trades(trades, selected_range)
    case selected_range
    when "7d"
      trades.where("exit_time >= ?", 7.days.ago.beginning_of_day)
    when "30d"
      trades.where("exit_time >= ?", 30.days.ago.beginning_of_day)
    when "1y"
      trades.where("exit_time >= ?", 1.year.ago.beginning_of_day)
    when "all"
      trades
    else
      trades.where("exit_time >= ?", 30.days.ago.beginning_of_day)
    end
  end

  def build_daily_equity_curve(trades)
    daily_pnl = trades.group_by_day(:exit_time).sum(:net_pnl)

    cumulative_pnl = 0

    daily_pnl.map do |day, pnl|
      cumulative_pnl += pnl.to_d
      [day, cumulative_pnl]
    end
  end
end