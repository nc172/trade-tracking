class AddUniqueIndexToTrades < ActiveRecord::Migration[8.1]
  def change
    add_index :trades,
              [:user_id, :buy_fill_id, :sell_fill_id],
              unique: true,
              name: "index_trades_on_user_and_fill_ids"
  end
end