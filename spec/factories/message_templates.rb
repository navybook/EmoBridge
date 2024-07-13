FactoryBot.define do
  factory :message_template do
    message { Faker::Lorem.sentence }
  end
end
