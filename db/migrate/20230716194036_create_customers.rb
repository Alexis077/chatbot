class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :last_name
      t.string :rut
      t.references :account, index: true, foreign_key: true
      t.timestamps
    end
  end
end
