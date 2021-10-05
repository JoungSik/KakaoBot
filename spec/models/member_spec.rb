require 'rails_helper'

RSpec.describe Member, type: :model do
  before(:each) do
    @client = FactoryBot.create(:client)
    @room = FactoryBot.create(:room, client: @client)
    @member = FactoryBot.create(:member, room: @room)
  end

  describe 'validate' do
    it 'presence' do
      member = Member.create({})
      member.validate
      expect(member.errors.full_messages).to include("Room must exist")
      expect(member.errors.full_messages).to include("Name can't be blank")
      expect(member.errors.full_messages).to include("Chat can't be blank")
    end

    it 'uniqueness' do
      member = Member.create({ room: @room, name: @member.name, chat_id: @member.chat_id })
      member.validate
      expect(member.errors.full_messages).to include("Chat has already been taken")
    end
  end

  describe 'create' do
    it 'room has many members' do
      member = Member.create({ room: @room, name: @member.name, chat_id: '9876543210987654321' })
      expect(@room.members).to include member
    end
  end

  describe 'delete' do
    it 'member delete to member attendances' do
      member = Member.create({ room: @room, name: @member.name, chat_id: '9876543210987654321' })

      MemberAttendance.create({ member: member, due_date: Date.today })
      MemberAttendance.create({ member: member, due_date: Date.today + 1.days })
      MemberAttendance.create({ member: member, due_date: Date.today + 2.days })

      expect(MemberAttendance.where(member_id: member.id).size).to eql 3

      member_id = member.id
      member.destroy

      expect(MemberAttendance.where(member_id: member_id).size).to eql 0
    end
  end
end
