require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/member_attendances", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @client = FactoryBot.create(:client, user_clients_attributes: [{ user: @user }])
    @room = FactoryBot.create(:room, client: @client)
    @member = FactoryBot.create(:member, room: @room)
    @member_attendance = FactoryBot.create(:member_attendance, member: @member)

    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
  end

  let(:valid_attributes) {
    {
      chat_id: @member.chat_id,
      due_date: @member_attendance.due_date + 1.days
    }
  }

  let(:invalid_attributes) {
    {
      due_date: @member_attendance.due_date
    }
  }

  describe "GET /index" do
    it 'authentication' do
      get member_attendances_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders a successful response" do
      get member_attendances_url(room_id: @room.id), headers: @auth_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eql @room.member_attendances.size
    end
  end

  # describe "GET /show" do
  #   it "renders a successful response" do
  #     member_attendance = MemberAttendance.create! valid_attributes
  #     get member_attendance_url(member_attendance), as: :json
  #     expect(response).to be_successful
  #   end
  # end

  describe "POST /create" do
    it 'authentication' do
      post member_attendances_url, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    context "with valid parameters" do
      it "creates a new MemberAttendance" do
        post member_attendances_url, params: valid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new MemberAttendance" do
        post member_attendances_url, params: invalid_attributes, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested member_attendance" do
  #       member_attendance = MemberAttendance.create! valid_attributes
  #       patch member_attendance_url(member_attendance),
  #             params: { member_attendance: new_attributes }, headers: valid_headers, as: :json
  #       member_attendance.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "renders a JSON response with the member_attendance" do
  #       member_attendance = MemberAttendance.create! valid_attributes
  #       patch member_attendance_url(member_attendance),
  #             params: { member_attendance: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including("application/json"))
  #     end
  #   end
  #
  #   context "with invalid parameters" do
  #     it "renders a JSON response with errors for the member_attendance" do
  #       member_attendance = MemberAttendance.create! valid_attributes
  #       patch member_attendance_url(member_attendance),
  #             params: { member_attendance: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to eq("application/json")
  #     end
  #   end
  # end
  #
  # describe "DELETE /destroy" do
  #   it "destroys the requested member_attendance" do
  #     member_attendance = MemberAttendance.create! valid_attributes
  #     expect {
  #       delete member_attendance_url(member_attendance), headers: valid_headers, as: :json
  #     }.to change(MemberAttendance, :count).by(-1)
  #   end
  # end
end
