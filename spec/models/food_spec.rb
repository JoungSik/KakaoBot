require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @food = FactoryBot.create(:food)
  end

  describe 'validate' do
    it 'presence' do
      food = Food.create({})
      food.validate
      expect(food.errors.full_messages).to include("Name can't be blank")
    end

    it 'uniqueness' do
      food = Food.create({ name: @food.name })
      food.validate
      expect(food.errors.full_messages).to include("Name has already been taken")
    end
  end

  describe 'create' do
    it 'create new food' do
      food = Food.create({ name: @food.name })
      expect(food).not_to eql nil
    end
  end

end
