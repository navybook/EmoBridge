FactoryBot.define do
  factory :emotion do
    user

    feeling { Emotion.feelings.keys.sample }

    feeling_score { rand(1..5) }

    factory :emotion_with_categories do
      transient do
        categories_count { 3 }
      end

      after(:create) do |emotion, evaluator|
        create_list(:emotion_category, evaluator.categories_count, emotion:)
      end
    end

    factory :emotion_with_message do
      after(:create) do |emotion, _evaluator|
        create(:emotion_message, emotion:)
      end
    end
  end
end
