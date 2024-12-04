FactoryBot.define do
  factory :notification do
    user
    association :partner, factory: :user  # partnerもユーザーとする
    emotion
    status { :unread }
  end
end
