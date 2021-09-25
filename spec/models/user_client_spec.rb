require 'rails_helper'

RSpec.describe UserClient, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @client = FactoryBot.create(:client)
  end

  describe 'association' do
    it 'has_many' do
      UserClient.create({ user: @user, client: @client })

      expect(@user.clients).to include @client
      expect(@client.users).to include @user
    end
  end

  describe 'validate' do
    it 'presence' do
      user_client = UserClient.create({})
      user_client.validate

      expect(user_client.errors.full_messages).to include("User must exist")
      expect(user_client.errors.full_messages).to include("Client must exist")
    end
  end
end
