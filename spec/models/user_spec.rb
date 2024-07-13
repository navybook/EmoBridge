require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with name, email, and password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = FactoryBot.build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it "is invalid with a duplicate email address" do
    existing_user = FactoryBot.create(:user, email: "user_1@example.com")
    user = FactoryBot.build(:user, email: "user_1@example.com")
    expect(user).to_not be_valid
  end

  it "is invalid with a short password" do
    user = FactoryBot.build(:user, password: 'short') 
    expect(user).to_not be_valid
  end
end