FactoryBot.define do
  factory :emotion_partner do
    user
    association :partner, factory: :user
  end
end
