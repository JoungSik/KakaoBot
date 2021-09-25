require 'rails_helper'

RSpec.describe "/users", type: :request do
  before(:each) do
    @password = 'qwer1234'
    @user = FactoryBot.create(:user, password: @password)
  end

  describe 'create user' do
    it 'success' do
      headers = { "ACCEPT" => "application/json" }
      post "/users", :params => { email: 'tjstlr2010@gmail.com', password: 'qwer1234', name: '김정식' }, :headers => headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['message']).to eql('회원가입에 성공했습니다.')
    end

    it 'failure' do
      headers = { "ACCEPT" => "application/json" }
      post "/users", :params => { email: @user.email, password: @user.password, name: @user.name }, :headers => headers

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'create session (login)' do
    it 'success' do
      headers = { "ACCEPT" => "application/json" }
      post "/login", :params => { email: @user.email, password: @password }, :headers => headers

      expect(response).to have_http_status(:ok)
      expect(response.header).to include('Authorization')
    end

    it 'failure' do
      headers = { "ACCEPT" => "application/json" }
      post "/login", :params => { email: @user.email, password: 'qwer' }, :headers => headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
