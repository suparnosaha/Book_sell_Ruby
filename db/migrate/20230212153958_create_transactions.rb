class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_number
      t.string :credit_card_number
      t.string :address
      t.string :phone_number
      t.integer :quantity
      t.integer :total_price

      t.timestamps
    end
  end
end
