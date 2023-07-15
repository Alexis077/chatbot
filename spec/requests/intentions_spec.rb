require 'rails_helper'

RSpec.describe "Intentions", type: :request do
  describe "POST /create" do
    let(:input_text) { 'Prueba' }
    it "returns http success" do
      post "/intentions"
      expect(response).to have_http_status(:success)
    end
  end
end