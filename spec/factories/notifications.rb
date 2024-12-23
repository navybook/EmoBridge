FactoryBot.define do
  factory :notification do
    user
    association :partner, factory: :user
    emotion
    status { :unread }
  end
end
