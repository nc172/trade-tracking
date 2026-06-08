class CreateImports < ActiveRecord::Migration[8.1]
  def change
    create_table :imports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :source_platform
      t.string :status
      t.text :error_message

      t.timestamps
    end
  end
end
