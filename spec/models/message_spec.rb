require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "associations" do
    it "belongs to a chat session" do
      chat_session = FactoryBot.create(:chat_session)
      message = FactoryBot.create(:message, chat_session: chat_session)
      expect(message.chat_session).to eq(chat_session)
    end
  end
end
