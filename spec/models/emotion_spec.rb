require 'rails_helper'

RSpec.describe Emotion, type: :model do
  it 'is valid with valid attributes' do
    emotion = FactoryBot.build(:emotion)
    expect(emotion).to be_valid
  end

  it 'is not valid without a user' do
    emotion = FactoryBot.build(:emotion, user: nil)
    expect(emotion).to_not be_valid
  end

  it 'is not valid without a feeling' do
    emotion = FactoryBot.build(:emotion, feeling: nil)
    expect(emotion).to_not be_valid
  end
end
