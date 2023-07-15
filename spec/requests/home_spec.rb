require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    let(:input_text) { 'Prueba' }
    it "returns http success" do
      post "/intentions"
      expect(response).to have_http_status(:success)
    end
  end

end
