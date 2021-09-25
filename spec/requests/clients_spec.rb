require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe '/clients', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @client = FactoryBot.create(:client, user_clients_attributes: [{ user: @user }])

    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
  end

  let(:valid_attributes) {
    {
      name: "JoungSik2-Desktop",
      email: "example2@example.com",
      phone: "+82-10-5678-1234",
      password: 'qwer1234',
      uuid: 'bm9kZS1rYWthbyDquLDrsJjsnLzroZwg6rWs7ZiE65CcIOyVhOuMgOyIsiDsubTsubTsmKQg67SHIO2BtOudvOydtOyWuO2KuA==',
      access_token: 'noaqatt6jnuv0fb5a5u0a69y1vwvw549lljrw3f4i2aesjme8nuqv1303ilp',
      refresh_token: '4i5a8lcrdqqq4y5fx47jvmi131g9opwf7ahcuw3trmxjvugbo26l26d2rbo13',
      client_id: 987654321
    }
  }

  let(:invalid_attributes) {
    {
      name: @client.name,
      email: @client.email,
      phone: @client.phone,
      password: @client.password,
      uuid: @client.uuid,
      access_token: @client.access_token,
      refresh_token: @client.refresh_token,
      client_id: @client.client_id
    }
  }

  describe 'GET /index' do
    it 'authentication' do
      get clients_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'renders a successful response' do
      get clients_url, headers: @auth_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eql @user.clients.size
    end
  end

  describe 'GET /show' do
    it 'authentication' do
      get client_url(@client), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'renders a successful response' do
      get client_url(@client), headers: @auth_headers, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    it 'authentication' do
      post clients_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    context 'with valid parameters' do
      it 'creates a new Client' do
        post clients_url, params: { client: valid_attributes }, headers: @auth_headers, as: :json
        client = Client.find JSON.parse(response.body)['id']

        expect(response).to have_http_status(:created)
        expect(client.user_clients.size).to eql 1
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Client' do
        post clients_url, params: { client: invalid_attributes }, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    it 'authentication' do
      patch client_url(@client), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    context 'with valid parameters' do
      let(:new_attributes) {
        {
          uuid: '66qo6rCB7L2U7Iuc66m0IOuqqOqwgey9lOuhnCDrs7TrgrTrk5zrpqzroKTqs6Ag7ZaI7KOgIOOFjuOFjg==',
          access_token: '09zpbz9u74l8c2zhlre4vgsivzr552gx6dvrkohxgu83downzv02mye27oss',
          refresh_token: 'uamfexplwtcp4zumcxxjuacrnjp0ygo8wd4rfsfmyk764dk2inzhnsq0s6g2'
        }
      }

      it 'updates the requested client' do
        uuid = @client.uuid
        access_token = @client.access_token
        refresh_token = @client.refresh_token
        user_client_count = @client.user_clients.size

        patch client_url(@client), params: { client: new_attributes }, headers: @auth_headers, as: :json
        @client.reload

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['uuid']).not_to eql uuid
        expect(JSON.parse(response.body)['access_token']).not_to eql access_token
        expect(JSON.parse(response.body)['refresh_token']).not_to eql refresh_token
        expect(user_client_count).to eql @client.user_clients.size
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the client' do
        client = Client.create! valid_attributes
        patch client_url(client), params: { client: invalid_attributes }, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'authentication' do
      delete client_url(@client), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'destroys the requested client' do
      expect {
        delete client_url(@client), headers: @auth_headers, as: :json
      }.to change(Client, :count).by(-1)
    end
  end
end
