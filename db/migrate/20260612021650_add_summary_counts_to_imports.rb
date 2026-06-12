class AddSummaryCountsToImports < ActiveRecord::Migration[8.1]
  def change
    add_column :imports, :processed_rows, :integer, default: 0, null: false
    add_column :imports, :created_trades_count, :integer, default: 0, null: false
    add_column :imports, :skipped_duplicates_count, :integer, default: 0, null: false
    add_column :imports, :failed_rows_count, :integer, default: 0, null: false
  end
end