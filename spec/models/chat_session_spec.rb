require 'rails_helper'

RSpec.describe ChatSession, type: :model do
  describe "validations" do
    it "is not valid without a session_id" do
      chat_session = FactoryBot.build(:chat_session, session_id: nil)
      expect(chat_session).not_to be_valid
    end

    it "raises an exception with an invalid status" do
      expect {
        FactoryBot.build(:chat_session, status: :invalid_status)
      }.to raise_error(ArgumentError, "'invalid_status' is not a valid status")
    end

    it "can create and save an open chat session" do
      chat_session = FactoryBot.build(:chat_session, status: :open)
      expect(chat_session).to be_valid
      expect(chat_session.save).to be true
    end

    it "can change the status from open to closed" do
      chat_session = FactoryBot.create(:chat_session, status: :open)
      chat_session.update(status: :closed)
      expect(chat_session.status).to eq("closed")
    end
  end
end