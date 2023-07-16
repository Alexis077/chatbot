class AddIntentionColumnToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :intention, :string, default: "none"
  end
end
