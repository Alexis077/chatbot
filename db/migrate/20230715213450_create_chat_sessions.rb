class CreateChatSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_sessions do |t|
      t.string :session_id
      t.string :status
      t.timestamps
    end
  end
end
