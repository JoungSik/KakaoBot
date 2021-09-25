require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  describe 'validate' do
    it 'presence' do
      user = User.create({})
      user.validate

      expect(user.errors.full_messages).to include("Email can't be blank")
      expect(user.errors.full_messages).to include("Password can't be blank")
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'uniqueness' do
      user = User.create({ email: @user.email, name: @user.name, password: @user.password })
      user.validate

      expect(user.errors.full_messages).to include("Email has already been taken")
      expect(user.errors.full_messages).to include("Name has already been taken")
    end
  end
end