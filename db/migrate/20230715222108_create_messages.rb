class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :chat_session, index: true, foreign_key: true
      t.string :text
      t.timestamps
    end
  end
end
