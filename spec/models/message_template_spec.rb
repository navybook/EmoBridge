require 'rails_helper'

RSpec.describe MessageTemplate, type: :model do
  it 'is valid with valid attributes' do
    message_template = FactoryBot.build(:message_template)
    expect(message_template).to be_valid
  end

  it 'is not valid without a message' do
    message_template = FactoryBot.build(:message_template, message: nil)
    expect(message_template).to_not be_valid
  end
end
