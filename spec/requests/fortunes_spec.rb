# require 'rails_helper'
# require 'devise/jwt/test_helpers'
#
# RSpec.describe "/fortunes", type: :request do
#   before(:each) do
#     @user = FactoryBot.create(:user)
#     @fortune = FactoryBot.create(:fortune)
#
#     @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
#     @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
#   end
#
#   describe "GET /index" do
#     it 'authentication' do
#       get fortunes_url, as: :json
#       expect(response).to have_http_status(:unauthorized)
#     end
#
#     it "renders a successful response" do
#       get fortunes_url(name: @fortune.name), headers: @auth_headers, as: :json
#       expect(response).to be_successful
#       expect(JSON.parse(response.body)['name']).to eql @fortune.name
#       expect(JSON.parse(response.body)['due_date']).to eql Date.today.strftime("%Y-%m-%d")
#     end
#   end
# end
