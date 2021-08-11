class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.date :transaction_date
      t.string :description
      t.decimal :amount
      t.references :family, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.string :slug, index: true, unique: true

      t.timestamps
    end
  end
end
