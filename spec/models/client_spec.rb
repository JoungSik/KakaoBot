require 'rails_helper'

RSpec.describe Client, type: :model do
  before(:each) do
    @client = FactoryBot.create(:client)
    @user = FactoryBot.create(:user)
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

  describe 'create' do
    it 'user client' do
      client = Client.create(
        {
          name: "JoungSik2-Desktop",
          email: "example2@example.com",
          phone: "+82-10-5678-1234",
          password: 'qwer1234',
          uuid: 'bm9kZS1rYWthbyDquLDrsJjsnLzroZwg6rWs7ZiE65CcIOyVhOuMgOyIsiDsubTsubTsmKQg67SHIO2BtOudvOydtOyWuO2KuA==',
          access_token: 'noaqatt6jnuv0fb5a5u0a69y1vwvw549lljrw3f4i2aesjme8nuqv1303ilp',
          refresh_token: '4i5a8lcrdqqq4y5fx47jvmi131g9opwf7ahcuw3trmxjvugbo26l26d2rbo13',
          client_id: 987654321,
          user_clients_attributes: [{ user: @user }]
        })
      expect(client.users).to include @user
    end
  end
end
