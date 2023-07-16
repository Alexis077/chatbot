require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "associations" do

    it "raises an exception with a blank message" do
      chat_session = FactoryBot.create(:chat_session)
      expect {
        FactoryBot.create(:message, chat_session: chat_session, text: "")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    
    it "belongs to a chat session" do
      chat_session = FactoryBot.create(:chat_session)
      message = FactoryBot.create(:message, chat_session: chat_session)
      expect(message.chat_session).to eq(chat_session)
    end

    it "raises an exception with an invalid intention" do
      chat_session = FactoryBot.create(:chat_session)
      expect {
        FactoryBot.create(:message, chat_session: chat_session, intention: :invalid_intention)
      }.to raise_error(ArgumentError, "'invalid_intention' is not a valid intention")
    end
  end
end
