require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with valid attributes' do
    category = FactoryBot.build(:category)
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = FactoryBot.build(:category, name: nil)
    expect(category).to_not be_valid
  end
end
