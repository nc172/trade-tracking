require "csv"

module Imports
  class TradovateCsvParser
    def initialize(import)
      @import = import
      @user = import.user
    end

    def call
      raise "No file attached" unless @import.file.attached?

      @import.file.open do |file|
        CSV.foreach(file.path, headers: true) do |row|
          create_trade_from_row(row)
        end
      end

      @import.update!(status: "completed", error_message: nil)
    rescue StandardError => e
      @import.update!(status: "failed", error_message: e.message)
      raise e
    end

    private

    def create_trade_from_row(row)
      bought_time = parse_time(row["boughtTimestamp"])
      sold_time = parse_time(row["soldTimestamp"])

      side = bought_time < sold_time ? "long" : "short"

      entry_time = side == "long" ? bought_time : sold_time
      exit_time = side == "long" ? sold_time : bought_time

      entry_price = side == "long" ? row["buyPrice"] : row["sellPrice"]
      exit_price = side == "long" ? row["sellPrice"] : row["buyPrice"]

      net_pnl = parse_money(row["pnl"])

      Trade.find_or_create_by!(
        user: @user,
        buy_fill_id: row["buyFillId"],
        sell_fill_id: row["sellFillId"]
      ) do |trade|
        trade.import = @import
        trade.symbol = row["symbol"]
        trade.side = side
        trade.quantity = row["qty"].to_i
        trade.entry_time = entry_time
        trade.exit_time = exit_time
        trade.entry_price = entry_price
        trade.exit_price = exit_price
        trade.gross_pnl = net_pnl
        trade.fees = 0
        trade.net_pnl = net_pnl
        trade.status = trade_status(net_pnl)
        trade.duration_seconds = parse_duration(row["duration"])
        trade.tick_size = row["_tickSize"]
      end
    end

    def parse_money(value)
      cleaned = value.to_s.strip

      if cleaned.start_with?("$(") && cleaned.end_with?(")")
        -cleaned.gsub(/[$(),]/, "").to_d
      else
        cleaned.gsub(/[$,]/, "").to_d
      end
    end

    def parse_time(value)
      Time.zone.strptime(value, "%m/%d/%Y %H:%M:%S")
    end

    def parse_duration(value)
      text = value.to_s

      minutes = text[/(\d+)min/, 1].to_i
      seconds = text[/(\d+)sec/, 1].to_i

      (minutes * 60) + seconds
    end

    def trade_status(net_pnl)
      if net_pnl.positive?
        "win"
      elsif net_pnl.negative?
        "loss"
      else
        "breakeven"
      end
    end
  end
end