class AddCsvFieldsToTrades < ActiveRecord::Migration[8.1]
  def change
    add_column :trades, :buy_fill_id, :string
    add_column :trades, :sell_fill_id, :string
    add_column :trades, :tick_size, :decimal
  end
end
