require 'rails_helper'

RSpec.describe BanKeyword, type: :model do
  before(:each) do
    @client = FactoryBot.create(:client)
    @room = FactoryBot.create(:room, client: @client)
    @ban_keyword = FactoryBot.create(:ban_keyword, room: @room)
  end

  describe 'validate' do
    it 'presence' do
      ban_keyword = BanKeyword.create({})
      ban_keyword.validate
      expect(ban_keyword.errors.full_messages).to include("Room must exist")
      expect(ban_keyword.errors.full_messages).to include("Name can't be blank")
      expect(ban_keyword.errors.full_messages).to include("Word can't be blank")
    end

    it 'uniqueness' do
      ban_keyword = BanKeyword.create({ room: @room, name: @ban_keyword.name, word: @ban_keyword.word })
      ban_keyword.validate
      expect(ban_keyword.errors.full_messages).to include("Name has already been taken")
      expect(ban_keyword.errors.full_messages).to include("Word has already been taken")
    end
  end

  describe 'create' do
    it 'room has many ban_keywords' do
      ban_keyword = BanKeyword.create({ room: @room, name: 'bitly', word: 'bitly' })
      expect(@room.ban_keywords).to include ban_keyword
    end
  end
end
