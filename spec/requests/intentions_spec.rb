require 'rails_helper'

RSpec.describe "Intentions", type: :request do
  describe "POST /create" do
    it "returns http success" do
      post "/intentions", params:{ input_text: 'Prueba'}, xhr: true
      expect(response).to have_http_status(:success)
      expect(ChatSession.count).to eq(1)
      chat_session = ChatSession.find_by(session_id: request.session[:session_id])
      messages = Message.where(chat_session: chat_session)
      expect(messages.count).to eq(1)
      expect(messages.first.text).to eq(I18n.t('intention.errors.not_valid_option'))
    end

    it "returns http success" do
      post "/intentions", params:{ input_text: "1"}, xhr: true
      expect(response).to have_http_status(:success)
      expect(ChatSession.count).to eq(1)
      chat_session = ChatSession.find_by(session_id: request.session[:session_id])
      messages = Message.where(chat_session: chat_session)
      expect(messages.count).to eq(1)
      expect(messages.first.text).to eq(Intention::DepositInquiry::Create.instruction_message)
    end
  end
end
