require 'rails_helper'

RSpec.describe Room, type: :model do
  before(:each) do
    @client = FactoryBot.create(:client)
    @room = FactoryBot.create(:room, client: @client)
  end

  describe 'validate' do
    it 'presence' do
      room = Room.create({})
      room.validate
      expect(room.errors.full_messages).to include("Client must exist")
      expect(room.errors.full_messages).to include("Name can't be blank")
      expect(room.errors.full_messages).to include("Channel can't be blank")
      expect(room.errors.full_messages).to include("Channel type can't be blank")
    end

    it 'uniqueness' do
      room = Room.create({ client: @client, name: @room.name, notice: @room.notice,
                           channel_id: @room.channel_id, channel_type: @room.channel_type })
      room.validate
      expect(room.errors.full_messages).to include("Name has already been taken")
      expect(room.errors.full_messages).to include("Channel has already been taken")
    end
  end

  describe 'create' do
    it 'client has many rooms' do
      room = Room.create({ client: @client, name: 'sample',
                           channel_id: '9876543210987654321', channel_type: @room.channel_type })
      expect(@client.rooms).to include room
    end
  end
end
