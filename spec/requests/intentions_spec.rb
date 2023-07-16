require 'rails_helper'

RSpec.describe "Intentions", type: :request do
  describe "POST /create" do
    let(:input_text) { 'Prueba' }
    it "returns http success" do
      post "/intentions"
      expect(response).to have_http_status(302)
      expect(ChatSession.count).to eq(1)
      chat_session = ChatSession.find_by(session_id: request.session[:session_id])
      expect(Message.where(chat_session: chat_session).count).to eq(1)
    end
  end
end
