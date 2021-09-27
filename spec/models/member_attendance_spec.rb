require 'rails_helper'

RSpec.describe MemberAttendance, type: :model do
  before(:each) do
    @client = FactoryBot.create(:client)
    @room = FactoryBot.create(:room, client: @client)
    @member = FactoryBot.create(:member, room: @room)
    @member_attendance = FactoryBot.create(:member_attendance, member: @member)
  end

  describe 'validate' do
    it 'presence' do
      member_attendance = MemberAttendance.create({})
      member_attendance.validate
      expect(member_attendance.errors.full_messages).to include("Member must exist")
    end

    it 'uniqueness' do
      member_attendance = MemberAttendance.create({ member: @member, due_date: @member_attendance.due_date })
      member_attendance.validate
      expect(member_attendance.errors.full_messages).to include("Due date has already been taken")
    end
  end

  describe 'create' do
    it 'member has many attendances' do
      member_attendance = MemberAttendance.create({ member: @member, due_date: @member_attendance.due_date + 1.days })
      expect(@member.attendances).to include member_attendance
    end
  end
end
