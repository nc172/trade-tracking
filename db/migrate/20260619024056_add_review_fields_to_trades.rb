class AddReviewFieldsToTrades < ActiveRecord::Migration[8.1]
  def change
    add_column :trades, :setup_type, :string
    add_column :trades, :mistake_type, :string
    add_column :trades, :emotion, :string
    add_column :trades, :plan_adherence, :string
    add_column :trades, :confidence_rating, :integer
    add_column :trades, :review_note, :text
  end
end
