require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:partner) { FactoryBot.create(:user) }
  let(:emotion) { FactoryBot.create(:emotion, user: partner) }

  it 'creates a notification after an emotion is created' do
    expect do
      FactoryBot.create(:notification, user:, partner:, emotion:)
    end.to change(Notification, :count).by(1)
  end

  it 'has the correct attributes' do
    notification = FactoryBot.build(:notification, user:, partner:, emotion:)
    expect(notification.user_id).to eq(user.id)
    expect(notification.partner_id).to eq(partner.id)
    expect(notification.emotion_id).to eq(emotion.id)
    expect(notification.status).to eq('unread')
  end
end
