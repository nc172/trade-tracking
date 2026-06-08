class CreateTrades < ActiveRecord::Migration[8.1]
  def change
    create_table :trades do |t|
      t.references :user, null: false, foreign_key: true
      t.references :import, null: false, foreign_key: true
      t.string :symbol
      t.string :side
      t.integer :quantity
      t.datetime :entry_time
      t.datetime :exit_time
      t.decimal :entry_price
      t.decimal :exit_price
      t.decimal :gross_pnl
      t.decimal :fees
      t.decimal :net_pnl
      t.string :status
      t.integer :duration_seconds

      t.timestamps
    end
  end
end
