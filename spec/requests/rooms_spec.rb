require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/rooms", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @client = FactoryBot.create(:client, user_clients_attributes: [{ user: @user }])
    @room = FactoryBot.create(:room, client: @client)

    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
  end

  let(:valid_attributes) {
    {
      name: 'sample',
      channel_id: '9876543210987654321',
      channel_type: @room.channel_type,
      notice: @room.notice,
      client_id: @client.id
    }
  }

  let(:invalid_attributes) {
    {
      name: @room.name,
      channel_id: @room.channel_id,
      channel_type: @room.channel_type,
      notice: @room.notice,
      client_id: @client.id
    }
  }

  describe "GET /index" do
    it 'authentication' do
      get rooms_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders a successful response" do
      get rooms_url, headers: @auth_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eql @user.rooms.size
    end
  end

  describe "GET /show" do
    it 'authentication' do
      get room_url(@room), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders a successful response" do
      get room_url(@room), headers: @auth_headers, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    it 'authentication' do
      post rooms_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    context "with valid parameters" do
      it "creates a new Room" do
        post rooms_url, params: valid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it 'authentication' do
        post rooms_url, as: :json
        expect(response).to have_http_status(:unauthorized)
      end

      it "does not create a new Room" do
        post rooms_url, params: invalid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    it 'authentication' do
      patch room_url(@room), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: 'sample',
          channel_id: '9876543210987654321',
          notice: '안녕하세요. 공지입니다.'
        }
      }

      it "updates the requested room" do
        name = @room.name
        channel_id = @room.channel_id
        notice = @room.notice

        patch room_url(@room), params: new_attributes, headers: @auth_headers, as: :json
        @room.reload

        expect(JSON.parse(response.body)['name']).not_to eql name
        expect(JSON.parse(response.body)['channel_id']).not_to eql channel_id
        expect(JSON.parse(response.body)['notice']).not_to eql notice
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the room" do
        room = Room.create! valid_attributes
        patch room_url(room), params: invalid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it 'authentication' do
      delete room_url(@room), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "destroys the requested room" do
      expect {
        delete room_url(@room), headers: @auth_headers, as: :json
      }.to change(Room, :count).by(-1)
    end
  end
end
