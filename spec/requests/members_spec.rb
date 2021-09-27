require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/members", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @client = FactoryBot.create(:client, user_clients_attributes: [{ user: @user }])
    @room = FactoryBot.create(:room, client: @client)
    @member = FactoryBot.create(:member, room: @room)

    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
  end

  let(:valid_attributes) {
    {
      name: @member.name,
      chat_id: '9876543210987654321',
      channel_id: @room.channel_id
    }
  }

  let(:invalid_attributes) {
    {
      name: @member.name,
      chat_id: @member.chat_id
    }
  }

  describe "GET /index" do
    it 'authentication' do
      get members_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders a successful response" do
      get members_url(channel_id: @room.channel_id), headers: @auth_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eql @room.members.size
    end
  end

  describe "GET /show" do
    it 'authentication' do
      get member_url(@member), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders a successful response" do
      get member_url(@member), headers: @auth_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it 'authentication' do
      post members_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    context "with valid parameters" do
      it "creates a new Member" do
        post members_url, params: valid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Member" do
        post members_url, params: invalid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    it 'authentication' do
      patch member_url(@member), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: '정식/27/남/BE'
        }
      }

      it "updates the requested member" do
        name = @member.name

        patch member_url(@member), params: new_attributes, headers: @auth_headers, as: :json
        @member.reload

        expect(JSON.parse(response.body)['name']).not_to eql name
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the member" do
        room = Room.find_by_channel_id valid_attributes[:channel_id]
        member = Member.create! valid_attributes.except!(:channel_id).reverse_merge(room: room)
        patch member_url(member), params: invalid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested member" do
      expect {
        delete member_url(@member), headers: @auth_headers, as: :json
      }.to change(Member, :count).by(-1)
    end
  end
end
