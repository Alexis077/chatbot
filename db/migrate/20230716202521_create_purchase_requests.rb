class CreatePurchaseRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_requests do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :address
      t.integer :amount
      t.integer :quantity
      t.integer :total
      t.date :deposit_date
      t.timestamps
    end
  end
end
