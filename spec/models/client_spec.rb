require 'rails_helper'

RSpec.describe Client, type: :model do
  before(:each) do
    @client = FactoryBot.create(:client)
  end

  describe 'validate' do
    it 'presence' do
      client = Client.create({})
      client.validate

      expect(client.errors.full_messages).to include("Email can't be blank")
      expect(client.errors.full_messages).to include("Name can't be blank")
      expect(client.errors.full_messages).to include("Password can't be blank")
      expect(client.errors.full_messages).to include("Phone can't be blank")
      expect(client.errors.full_messages).to include("Uuid can't be blank")
      expect(client.errors.full_messages).to include("Access token can't be blank")
      expect(client.errors.full_messages).to include("Refresh token can't be blank")
      expect(client.errors.full_messages).to include("Client can't be blank")
    end

    it 'uniqueness' do
      client = Client.create({ email: @client.email, name: @client.name, phone: @client.phone,
                               password: @client.password, uuid: @client.uuid, client_id: @client.client_id,
                               access_token: @client.access_token, refresh_token: @client.refresh_token })
      client.validate

      expect(client.errors.full_messages).to include("Email has already been taken")
      expect(client.errors.full_messages).to include("Phone has already been taken")
      expect(client.errors.full_messages).to include("Uuid has already been taken")
      expect(client.errors.full_messages).to include("Access token has already been taken")
      expect(client.errors.full_messages).to include("Refresh token has already been taken")
      expect(client.errors.full_messages).to include("Client has already been taken")
    end
  end
end
