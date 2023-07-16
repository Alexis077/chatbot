class AddDefaultStatusToChatSession < ActiveRecord::Migration[7.0]
  def change
    change_column :chat_sessions, :status, :string, default: 'initialized'
  end
end
