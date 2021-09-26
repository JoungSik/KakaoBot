require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/foods", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @food = FactoryBot.create(:food)

    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
  end

  describe "GET /index" do
    it 'authentication' do
      get foods_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders a successful response" do
      get foods_url, headers: @auth_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)['name']).to eql @food.name
    end
  end

end
