require 'rails_helper'

RSpec.describe Fortune, type: :model do
  before(:each) do
    @fortune = FactoryBot.create(:fortune)
  end

  describe 'validate' do
    it 'presence' do
      fortune = Fortune.create({})
      fortune.validate
      expect(fortune.errors.full_messages).to include("Name can't be blank")
      expect(fortune.errors.full_messages).to include("Content can't be blank")
    end

    it 'uniqueness' do
      fortune = Fortune.create({ name: @fortune.name, content: @fortune.content, due_date: @fortune.due_date })
      fortune.validate
      expect(fortune.errors.full_messages).to include("Name has already been taken")
    end
  end

  describe 'create' do
    it 'create new fortune' do
      fortune = Fortune.create({ name: @fortune.name, content: @fortune.content, due_date: @fortune.due_date + 1.days })
      expect(fortune).not_to eql nil
    end
  end
end
