require 'rails_helper'

RSpec.describe EmotionPartner, type: :model do
  it 'is valid with valid attributes' do
    emotion_partner = FactoryBot.create(:emotion_partner)
    expect(emotion_partner).to be_valid
  end

  it "is not valid without a user" do
    emotion_partner = FactoryBot.build(:emotion_partner, user: nil)
    expect(emotion_partner).to_not be_valid
  end

  it "is not valid without a partner" do
    emotion_partner = FactoryBot.build(:emotion_partner, partner: nil)
    expect(emotion_partner).to_not be_valid
  end
end
